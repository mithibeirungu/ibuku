class ApplicationController < ActionController::API
  # Catch unhandled errors and return informative JSON messages instead of silent 500s
  rescue_from StandardError do |exception|
    Rails.logger.error("Unhandled Exception [#{exception.class}]: #{exception.message}\n#{exception.backtrace&.first(8)&.join("\n")}")

    user_friendly_message = case exception
    when ActiveRecord::PendingMigrationError
      "Database migrations are pending. Please run: bin/rails db:migrate"
    when ActiveRecord::NoDatabaseError
      "Database does not exist. Please run: bin/rails db:create db:migrate db:seed"
    when ActiveRecord::StatementInvalid
      if exception.message.include?("relation \"admins\" does not exist")
        "The 'admins' database table does not exist. Please run: bin/rails db:migrate"
      else
        "Database error: #{exception.message}"
      end
    else
      exception.message.presence || "An unexpected server error occurred."
    end

    render json: {
      error: user_friendly_message,
      exception_class: exception.class.to_s
    }, status: :internal_server_error
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  attr_reader :current_admin

  private

  # Stateless Bearer Token Authentication (Supports Authorization header and ?token= query param for file downloads)
  def authenticate_admin!
    header = request.headers["Authorization"]
    token = header.split(" ").last if header.present?
    token ||= params[:token].presence

    if token.blank?
      render json: { error: "Authentication required: missing Bearer token" }, status: :unauthorized
      return
    end

    payload = ::Admin.decode_auth_token(token)
    if payload.nil?
      render json: { error: "Invalid or expired session token. Please re-authenticate." }, status: :unauthorized
      return
    end

    @current_admin = ::Admin.find_by(id: payload[:admin_id])
    if @current_admin.nil?
      render json: { error: "Admin account no longer exists." }, status: :unauthorized
    end
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def parameter_missing(exception)
    render json: { error: "Missing required parameter: #{exception.param}" }, status: :bad_request
  end
end
