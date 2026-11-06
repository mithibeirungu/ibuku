require "csv"

module Api
  module V1
    module Admin
      class DashboardController < ApplicationController
        before_action :authenticate_admin!

        # GET /api/v1/admin/dashboard/stats
        def stats
          # Scoped to current admin or system wide
          course_ids = current_admin.courses.pluck(:id)
          registrations = Registration.where(course_id: course_ids)

          total = registrations.count
          confirmed = registrations.where(status: "confirmed").count
          pending = registrations.where(status: "pending_review").count
          
          # If no courses created yet, calculate overall
          if course_ids.empty?
            total = Registration.count
            confirmed = Registration.where(status: "confirmed").count
            pending = Registration.where(status: "pending_review").count
          end

          render json: {
            total_registrations: total,
            confirmed_count: confirmed,
            confirmed_percentage: total.positive? ? ((confirmed.to_f / total) * 100).round(1) : 100.0,
            exceptions_count: pending,
            active_courses_count: current_admin.courses.where("registration_deadline >= ?", Time.current).count,
            admin_profile: {
              name: current_admin.name,
              email: current_admin.email,
              role: current_admin.role
            }
          }
        end

        # GET /api/v1/admin/dashboard/students
        def students
          scope = Registration.includes(:course).order(created_at: :desc)

          if params[:course_id].present?
            scope = scope.where(course_id: params[:course_id])
          end

          if params[:status].present? && params[:status] != "all"
            scope = scope.where(status: params[:status])
          end

          if params[:search].present?
            q = "%#{params[:search].to_s.strip.downcase}%"
            scope = scope.where(
              "LOWER(full_name) LIKE :q OR LOWER(key_number) LIKE :q OR LOWER(email) LIKE :q",
              q: q
            )
          end

          page = [params[:page].to_i, 1].max
          per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 10
          total_count = scope.count
          records = scope.offset((page - 1) * per_page).limit(per_page)

          render json: {
            data: records.map { |r| student_row_payload(r) },
            meta: {
              total_count: total_count,
              page: page,
              per_page: per_page,
              total_pages: (total_count.to_f / per_page).ceil
            }
          }
        end

        # PATCH /api/v1/admin/dashboard/students/:id
        def update_student
          reg = Registration.find(params[:id])
          
          if params[:full_name].present?
            reg.full_name = params[:full_name].to_s.strip
            seed_str = "IBUKU-LEDGER:#{reg.course_id}:#{reg.key_number}:#{reg.full_name}:#{Time.current.to_f}"
            reg.ledger_hash = Digest::SHA256.hexdigest(seed_str)
          end

          if params[:status].present?
            reg.status = params[:status]
          end

          if reg.save
            render json: { success: true, student: student_row_payload(reg) }
          else
            render json: { errors: reg.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # GET /api/v1/admin/dashboard/export_all_csv
        def export_all_csv
          scope = Registration.includes(:course).order(created_at: :desc)
          
          if params[:course_id].present?
            scope = scope.where(course_id: params[:course_id])
          end

          csv_data = CSV.generate(headers: true) do |csv|
            csv << [
              "Record ID",
              "Key Number",
              "Full Name (To Be Printed)",
              "Email",
              "Status",
              "Course Code",
              "Course Name",
              "Registration Timestamp",
              "Ledger SHA-256 Hash"
            ]

            scope.find_each do |reg|
              csv << [
                "REC-#{44000 + reg.id}",
                reg.key_number,
                reg.full_name,
                reg.email,
                reg.status,
                reg.course.course_code,
                reg.course.name,
                reg.created_at.strftime("%Y-%m-%d %H:%M:%S"),
                reg.ledger_hash
              ]
            end
          end

          send_data csv_data,
                    filename: "IBUKU_Registry_Export_#{Time.current.strftime('%Y%m%d_%H%M%S')}.csv",
                    type: "text/csv; charset=utf-8; header=present"
        end

        private

        def student_row_payload(r)
          initials = r.full_name.split(" ").map { |n| n[0] }.compact.first(2).join.upcase
          initials = "ST" if initials.blank?

          {
            id: r.id,
            key_number: r.key_number,
            full_name: r.full_name,
            initials: initials,
            email: r.email || "#{r.full_name.parameterize}@academic.edu",
            registration_datetime: r.created_at.strftime("%Y-%m-%d • %H:%M:%S"),
            batch_label: "Batch: US-WEST-A",
            status: r.status,
            ledger_hash: r.ledger_hash,
            course_id: r.course_id,
            course_code: r.course.course_code,
            course_name: r.course.name
          }
        end
      end
    end
  end
end

