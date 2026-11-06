class AdminMailer < ApplicationMailer
  def otp_email(admin, otp)
    @admin = admin
    @otp = otp
    @expires_in_minutes = 10

    mail(
      to: @admin.email,
      subject: "IBUKU Admin Access Code: #{@otp} [Action Required]"
    )
  end
end

