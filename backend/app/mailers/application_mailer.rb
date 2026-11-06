class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_SENDER", "registrar-no-reply@ibuku.edu")
  layout "mailer"
end

