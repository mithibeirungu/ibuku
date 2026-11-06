require "csv"

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :authenticate_admin!, only: [:create, :admin_index, :export_csv]
      before_action :set_course, only: [:show, :export_csv]

      # GET /api/v1/courses
      def index
        courses = Course.order(created_at: :desc)
        render json: courses.map { |c| course_summary_payload(c) }
      end

      # GET /api/v1/courses/lookup?code=CS-4091
      def lookup
        code = params[:code].to_s.strip.upcase
        course = Course.find_by("UPPER(course_code) = ?", code)

        if course
          render json: course_detail_payload(course)
        else
          render json: { error: "Course with code '#{code}' was not found in the registry." }, status: :not_found
        end
      end

      # GET /api/v1/courses/:id_or_code
      def show
        render json: course_detail_payload(@course)
      end

      # POST /api/v1/courses
      def create
        @course = current_admin.courses.build(course_params)

        if @course.save
          render json: course_detail_payload(@course), status: :created
        else
          render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/courses/:id/export_csv
      def export_csv
        registrations = @course.registrations.order(created_at: :asc)

        csv_data = CSV.generate(headers: true) do |csv|
          csv << ["Key Number", "Full Name", "Email", "Status", "Course Code", "Course Name", "Registration Timestamp", "Ledger Hash (SHA-256)"]
          registrations.each do |reg|
            csv << [
              reg.key_number,
              reg.full_name,
              reg.email,
              reg.status,
              @course.course_code,
              @course.name,
              reg.created_at.iso8601,
              reg.ledger_hash
            ]
          end
        end

        send_data csv_data,
                  filename: "IBUKU_#{@course.course_code}_Registrations_#{Time.current.strftime('%Y%m%d%H%M')}.csv",
                  type: "text/csv; charset=utf-8; header=present"
      end

      private

      def set_course
        identifier = params[:id_or_code] || params[:id]
        @course = Course.find_by("UPPER(course_code) = ?", identifier.to_s.upcase) ||
                  Course.find_by(id: identifier)

        unless @course
          render json: { error: "Course not found" }, status: :not_found
        end
      end

      def course_params
        params.require(:course).permit(
          :name,
          :course_code,
          :start_date,
          :end_date,
          :registration_deadline,
          :department,
          :cohort
        )
      end

      def course_summary_payload(c)
        {
          id: c.id,
          name: c.name,
          course_code: c.course_code,
          start_date: c.start_date,
          end_date: c.end_date,
          registration_deadline: c.registration_deadline,
          is_open: c.registration_open?,
          registrations_count: c.registrations.count
        }
      end

      def course_detail_payload(c)
        {
          id: c.id,
          name: c.name,
          course_code: c.course_code,
          start_date: c.start_date,
          end_date: c.end_date,
          registration_deadline: c.registration_deadline,
          formatted_date_range: c.formatted_date_range,
          formatted_deadline: c.formatted_deadline,
          department: c.department,
          cohort: c.cohort,
          registration_open: c.registration_open?,
          registrations_count: c.registrations.count,
          qr_payload_url: c.qr_payload_url,
          admin: {
            name: c.admin&.name,
            email: c.admin&.email
          }
        }
      end
    end
  end
end

