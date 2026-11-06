require "rqrcode"

class Course < ApplicationRecord
  belongs_to :admin
  has_many :registrations, dependent: :destroy

  validates :name, presence: true
  validates :course_code, presence: true, uniqueness: { case_sensitive: false }
  validates :start_date, :end_date, :registration_deadline, presence: true

  before_validation :generate_course_code, on: :create
  before_validation :normalize_course_code

  def registration_open?
    Time.current <= registration_deadline
  end

  def formatted_date_range
    "#{start_date.strftime('%B %d, %Y')} - #{end_date.strftime('%B %d, %Y')}"
  end

  def formatted_deadline
    # E.g. "18:00 EST • Nov 02, 2026"
    registration_deadline.strftime("%H:%M %Z • %b %d, %Y")
  end

  # Generates QR Code SVG string for frontend direct rendering or download
  def qr_code_svg(frontend_url = nil)
    url = frontend_url || "#{ENV.fetch('FRONTEND_URL', 'http://localhost:5173')}/courses/#{course_code}"
    qrcode = RQRCode::QRCode.new(url)
    qrcode.as_svg(
      color: "282828",
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true,
      use_path: true
    )
  end

  # Generates QR Code data payload
  def qr_payload_url(base_url = nil)
    base = base_url || ENV.fetch("FRONTEND_URL", "http://localhost:5173")
    "#{base.chomp('/')}/courses/#{course_code}"
  end

  private

  def normalize_course_code
    self.course_code = course_code.to_s.strip.upcase
  end

  def generate_course_code
    return if course_code.present?

    # Extract 2-4 uppercase characters from name or default to CS
    prefix = name.to_s.gsub(/[^a-zA-Z]/, "").upcase[0..2]
    prefix = "CS" if prefix.blank? || prefix.length < 2

    # Generate unique 4-digit code e.g. CS-4091
    loop do
      random_num = rand(1000..9999)
      generated = "#{prefix}-#{random_num}"
      unless Course.exists?(course_code: generated)
        self.course_code = generated
        break
      end
    end
  end
end

