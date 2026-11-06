module Api
  module V1
    class RegistrationsController < ApplicationController
      before_action :set_course, only: [:create, :check, :update]
      before_action :set_registration, only: [:show, :update]

      # POST /api/v1/courses/:course_id/registrations
      # Creates DB entry; intercepts existing users and redirects to their previous enrollment
      def create
        key = registration_params[:key_number].to_s.strip.upcase

        # Check for existing registration under this key for this course
        existing = @course.registrations.find_by(key_number: key)
        if existing
          render json: {
            intercepted: true,
            message: "Student key '#{key}' is already registered for this course. Redirecting to your existing certificate verification record.",
            registration: registration_payload(existing),
            redirect_to: "/courses/#{@course.course_code}/certificate/#{existing.id}"
          }, status: :ok
          return
        end

        # Verify deadline before creation
        unless @course.registration_open?
          render json: {
            error: "The registration window for this course closed on #{@course.formatted_deadline}. New registrations can no longer be accepted."
          }, status: :unprocessable_entity
          return
        end

        reg = @course.registrations.build(registration_params)
        reg.key_number = key

        if reg.save
          render json: {
            intercepted: false,
            message: "Registration successfully recorded into the archival ledger.",
            registration: registration_payload(reg),
            redirect_to: "/courses/#{@course.course_code}/certificate/#{reg.id}"
          }, status: :created
        else
          render json: { errors: reg.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/courses/:course_id/registrations/check?key_number=...
      # Name Check & Verification inspection
      def check
        key = params[:key_number].to_s.strip.upcase

        if key.blank?
          render json: { error: "Key number is required to inspect records." }, status: :bad_request
          return
        end

        reg = @course.registrations.find_by(key_number: key)

        if reg
          render json: {
            found: true,
            registration: registration_payload(reg),
            can_edit: @course.registration_open?
          }, status: :ok
        else
          render json: {
            found: false,
            error: "No certificate registration was located for Key '#{key}' in course #{@course.course_code}."
          }, status: :not_found
        end
      end

      # GET /api/v1/registrations/:id
      def show
        render json: {
          registration: registration_payload(@registration),
          course: {
            id: @registration.course.id,
            name: @registration.course.name,
            course_code: @registration.course.course_code,
            department: @registration.course.department,
            cohort: @registration.course.cohort,
            registration_deadline: @registration.course.registration_deadline,
            registration_open: @registration.course.registration_open?
          },
          can_edit: @registration.course.registration_open?
        }
      end

      # PATCH /api/v1/courses/:course_id/registrations/:id
      # Name correction / adjustment prior to cutoff
      def update
        unless @course.registration_open?
          render json: {
            error: "The modification cutoff for #{@course.name} passed on #{@course.formatted_deadline}. Name orthography is sealed."
          }, status: :forbidden
          return
        end

        new_name = params[:registration][:full_name].to_s.strip

        if new_name.blank?
          render json: { error: "Full Name cannot be empty." }, status: :bad_request
          return
        end

        # Recompute ledger hash on update
        @registration.full_name = new_name
        seed_str = "IBUKU-LEDGER:#{@registration.course_id}:#{@registration.key_number}:#{new_name}:#{Time.current.to_f}"
        @registration.ledger_hash = Digest::SHA256.hexdigest(seed_str)

        if @registration.save
          render json: {
            success: true,
            message: "Student certificate name updated and re-verified successfully.",
            registration: registration_payload(@registration)
          }, status: :ok
        else
          render json: { errors: @registration.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_course
        identifier = params[:course_id]
        @course = Course.find_by("UPPER(course_code) = ?", identifier.to_s.upcase) ||
                  Course.find_by(id: identifier)

        unless @course
          render json: { error: "Course not found" }, status: :not_found
        end
      end

      def set_registration
        @registration = Registration.find_by(id: params[:id])
        unless @registration
          render json: { error: "Registration record not found" }, status: :not_found
        end
      end

      def registration_params
        params.require(:registration).permit(:key_number, :full_name, :email)
      end

      def registration_payload(reg)
        {
          id: reg.id,
          key_number: reg.key_number,
          full_name: reg.full_name,
          email: reg.email,
          status: reg.status,
          rec_number: "REC ##{44000 + reg.id}",
          ledger_hash: reg.ledger_hash,
          short_hash: "#{reg.ledger_hash[0..15]}...#{reg.ledger_hash[-4..]}",
          created_at: reg.created_at,
          formatted_date: reg.created_at.strftime("%Y-%m-%d • %H:%M:%S"),
          course_id: reg.course_id,
          course_code: reg.course.course_code,
          course_name: reg.course.name,
          department: reg.course.department
        }
      end
    end
  end
end

