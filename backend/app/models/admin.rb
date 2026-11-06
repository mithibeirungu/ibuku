require "bcrypt"
require "securerandom"

class Admin < ApplicationRecord
  has_many :courses, dependent: :destroy

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :downcase_email

  # 10 minute OTP expiration window
  OTP_EXPIRATION_TIME = 10.minutes

  # Secure stateless OTP generator
  def generate_otp!
    raw_otp = SecureRandom.random_number(100_000..999_999).to_s
    self.otp_digest = BCrypt::Password.create(raw_otp)
    self.otp_sent_at = Time.current
    save!(validate: false)
    raw_otp
  end

  # Verifies the submitted OTP against the BCrypt digest
  def authenticate_otp(submitted_otp)
    return false if otp_digest.blank? || otp_sent_at.blank?
    return false if otp_sent_at < OTP_EXPIRATION_TIME.ago

    bcrypt_pass = BCrypt::Password.new(otp_digest)
    if bcrypt_pass == submitted_otp.to_s.strip
      # Invalidate immediately to prevent replay attacks
      update_columns(otp_digest: nil, otp_sent_at: nil)
      true
    else
      false
    end
  rescue BCrypt::Errors::InvalidHash
    false
  end

  # Generate stateless HS256 JWT auth token
  def generate_auth_token
    payload = {
      admin_id: id,
      email: email,
      name: name,
      role: role,
      exp: 24.hours.from_now.to_i,
      iat: Time.current.to_i
    }
    JWT.encode(payload, Rails.application.secret_key_base, "HS256")
  end

  def self.decode_auth_token(token)
    decoded = JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: "HS256" })
    decoded.first.with_indifferent_access
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  private

  def downcase_email
    self.email = email.to_s.strip.downcase
  end
end

