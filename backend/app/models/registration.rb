require "digest"

class Registration < ApplicationRecord
  belongs_to :course

  validates :key_number, presence: true
  validates :full_name, presence: true, length: { minimum: 2, maximum: 120 }
  validates :key_number, uniqueness: { scope: :course_id, message: "already registered for this course" }

  before_validation :normalize_fields
  before_create :generate_ledger_hash

  validate :course_deadline_must_be_active, on: :create
  validate :course_deadline_must_be_active_on_update, on: :update

  def formatted_key
    key_number.upcase
  end

  def formatted_timestamp
    created_at.strftime("%Y-%m-%d • %H:%M:%S")
  end

  def print_emulsion_preview
    {
      line: full_name,
      course_name: course.name,
      course_code: course.course_code,
      key_number: key_number,
      ledger_hash: ledger_hash,
      issued_at: created_at
    }
  end

  private

  def normalize_fields
    self.key_number = key_number.to_s.strip.upcase
    self.full_name = full_name.to_s.strip.squeeze(" ")
    self.email = email.to_s.strip.downcase if email.present?
  end

  def generate_ledger_hash
    seed_str = "IBUKU-LEDGER:#{course_id}:#{key_number}:#{full_name}:#{Time.current.to_f}"
    self.ledger_hash ||= Digest::SHA256.hexdigest(seed_str)
  end

  def course_deadline_must_be_active
    return unless course

    unless course.registration_open?
      errors.add(:base, "The registration deadline for #{course.name} (#{course.formatted_deadline}) has passed. Further submissions are locked.")
    end
  end

  def course_deadline_must_be_active_on_update
    return unless course

    unless course.registration_open?
      errors.add(:base, "The modification deadline for #{course.name} (#{course.formatted_deadline}) has passed. Name adjustments are locked.")
    end
  end
end

