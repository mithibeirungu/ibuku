module Api
  module V1
    class AuthController < ApplicationController
      before_action :authenticate_admin!, only: [:me]

      DEFAULT_SUPER_ADMIN = "mithibeirungu@gmail.com".freeze

      # POST /api/v1/auth/request_otp
      # Stateless OTP dispatch via email
      def request_otp
        email = params[:email].to_s.strip.downcase

        if email.blank?
          render json: { error: "Email address is required" }, status: :bad_request
          return
        end

        # Check database table presence gracefully using top-level ::Admin model
        begin
          admin = ::Admin.find_by(email: email)
        rescue ActiveRecord::StatementInvalid => e
          if e.message.include?("relation \"admins\" does not exist")
            render json: {
              error: "Database table 'admins' does not exist yet. Please run migrations in your terminal: 'bin/rails db:migrate'."
            }, status: :internal_server_error
            return
          else
            raise
          end
        rescue ActiveRecord::NoDatabaseError
          render json: {
            error: "PostgreSQL database does not exist yet. Please run in your terminal: 'bin/rails db:create db:migrate db:seed'."
          }, status: :internal_server_error
          return
        end

        if admin.nil?
          # Auto-provision the default super-admin or initial account
          if email == DEFAULT_SUPER_ADMIN || ::Admin.count.zero?
            admin = ::Admin.create!(
              email: email,
              name: (email == DEFAULT_SUPER_ADMIN ? "Mithibe Irungu" : "Registrar Officer"),
              role: "super_admin"
            )
            Rails.logger.info("Auto-provisioned Super-Admin: #{admin.email}")
          else
            render json: {
              error: "Admin account '#{email}' is not registered. Please have the primary super-admin (#{DEFAULT_SUPER_ADMIN}) register your account first."
            }, status: :not_found
            return
          end
        end

        raw_otp = admin.generate_otp!

        # Prominently log to server console so developers can instantly view in terminal
        Rails.logger.info("\n=======================================================")
        Rails.logger.info(">>> IBUKU ADMIN OTP FOR [#{admin.email}]: #{raw_otp} <<<")
        Rails.logger.info("=======================================================\n")

        begin
          AdminMailer.otp_email(admin, raw_otp).deliver_now
        rescue StandardError => e
          Rails.logger.warn("AdminMailer notice (delivery suppressed or failed): #{e.message}")
        end

        response_payload = {
          success: true,
          message: "A 6-digit cryptographic verification code has been dispatched to #{admin.email}."
        }

        # Include OTP in JSON payload in development, test, or when SMTP is not configured
        if Rails.env.development? || Rails.env.test? || ENV["ENABLE_DEV_OTP"] != "false"
          response_payload[:dev_otp] = raw_otp
        end

        render json: response_payload, status: :ok
      end

      # POST /api/v1/auth/verify_otp
      # Verify OTP and generate stateless HS256 JWT
      def verify_otp
        email = params[:email].to_s.strip.downcase
        otp = params[:otp].to_s.strip

        if email.blank? || otp.blank?
          render json: { error: "Both email and OTP code are required" }, status: :bad_request
          return
        end

        admin = ::Admin.find_by(email: email)
        if admin.nil?
          render json: { error: "Admin account not found" }, status: :not_found
          return
        end

        if admin.authenticate_otp(otp)
          token = admin.generate_auth_token
          render json: {
            success: true,
            token: token,
            admin: {
              id: admin.id,
              email: admin.email,
              name: admin.name,
              role: admin.role,
              is_super_admin: (admin.email == DEFAULT_SUPER_ADMIN || admin.role == "super_admin")
            }
          }, status: :ok
        else
          render json: { error: "Invalid or expired passcode. Please request a new one." }, status: :unauthorized
        end
      end

      # GET /api/v1/auth/me
      def me
        render json: {
          admin: {
            id: current_admin.id,
            email: current_admin.email,
            name: current_admin.name,
            role: current_admin.role,
            is_super_admin: (current_admin.email == DEFAULT_SUPER_ADMIN || current_admin.role == "super_admin")
          }
        }
      end
    end
  end
end
