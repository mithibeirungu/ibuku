module Api
  module V1
    module Admin
      class AdminsController < ApplicationController
        before_action :authenticate_admin!

        PRIMARY_SUPER_ADMIN = "mithibeirungu@gmail.com".freeze

        # GET /api/v1/admin/admins
        def index
          admins = ::Admin.order(created_at: :asc)
          render json: admins.map { |a| admin_summary(a) }
        end

        # POST /api/v1/admin/admins
        # Register a new admin account
        def create
          email = params[:email].to_s.strip.downcase
          name = params[:name].to_s.strip
          role = params[:role].to_s.strip.presence || "registrar"

          if email.blank?
            render json: { error: "Email address is required to register an admin." }, status: :bad_request
            return
          end

          if ::Admin.exists?(email: email)
            render json: { error: "An administrator with email '#{email}' is already registered." }, status: :unprocessable_entity
            return
          end

          new_admin = ::Admin.new(
            email: email,
            name: name.presence || "Registrar Officer",
            role: role
          )

          if new_admin.save
            render json: {
              success: true,
              message: "Administrator '#{new_admin.email}' has been successfully provisioned.",
              admin: admin_summary(new_admin)
            }, status: :created
          else
            render json: { errors: new_admin.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/admins/:id
        def destroy
          admin = ::Admin.find_by(id: params[:id])

          if admin.nil?
            render json: { error: "Admin account not found." }, status: :not_found
            return
          end

          if admin.email == PRIMARY_SUPER_ADMIN
            render json: { error: "The default primary super-admin (#{PRIMARY_SUPER_ADMIN}) cannot be deleted." }, status: :forbidden
            return
          end

          if admin.id == current_admin.id
            render json: { error: "You cannot delete your own active administrator account." }, status: :forbidden
            return
          end

          admin.destroy
          render json: { success: true, message: "Administrator '#{admin.email}' was removed from the registry." }
        end

        private

        def admin_summary(a)
          {
            id: a.id,
            email: a.email,
            name: a.name,
            role: a.role,
            is_primary: (a.email == PRIMARY_SUPER_ADMIN),
            is_current: (a.id == current_admin.id),
            created_at: a.created_at.strftime("%Y-%m-%d • %H:%M:%S")
          }
        end
      end
    end
  end
end

