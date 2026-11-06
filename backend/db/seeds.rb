# This file seeds initial records matching the IBUKU specification and designs.

puts "== Seeding IBUKU Database =="

# 1. Provision Default Primary Super-Admin
primary_super_admin = Admin.find_or_create_by!(email: "mithibeirungu@gmail.com") do |admin|
  admin.name = "Mithibe Irungu"
  admin.role = "super_admin"
  admin.otp_digest = nil
  admin.otp_sent_at = nil
end

puts "Provisioned Default Super-Admin: #{primary_super_admin.name} (#{primary_super_admin.email})"

# 1b. Provision Legacy Registrar Officer
secondary_admin = Admin.find_or_create_by!(email: "registrar@ibuku.edu") do |admin|
  admin.name = "Prof. V. Sterling"
  admin.role = "registrar"
  admin.otp_digest = nil
  admin.otp_sent_at = nil
end

puts "Provisioned Registrar Admin: #{secondary_admin.name} (#{secondary_admin.email})"

# 2. Provision Canonical Design Course: CS-4091
course = Course.find_or_initialize_by(course_code: "CS-4091")
course.assign_attributes(
  name: "Advanced Systems Architecture & Distributed Systems",
  department: "Dept. of Computer Science",
  cohort: "Cohort: Q4 2026",
  start_date: Date.new(2026, 10, 24),
  end_date: Date.new(2026, 10, 30),
  registration_deadline: DateTime.new(2026, 11, 20, 18, 0, 0, "-05:00"),
  admin: primary_super_admin
)
course.save!

puts "Provisioned Course: #{course.course_code} - #{course.name}"

# 2b. Secondary Course for Multi-Course verification
course2 = Course.find_or_initialize_by(course_code: "BIO-102")
course2.assign_attributes(
  name: "Cellular Biochemistry & Molecular Genetics",
  department: "Dept. of Biological Sciences",
  cohort: "Cohort: Q1 2027",
  start_date: Date.new(2027, 1, 10),
  end_date: Date.new(2027, 3, 25),
  registration_deadline: DateTime.new(2027, 4, 1, 23, 59, 59, "-05:00"),
  admin: primary_super_admin
)
course2.save!

puts "Provisioned Course: #{course2.course_code} - #{course2.name}"

# 3. Provision Registered Students matching the official Archival Ledger designs
students_data = [
  {
    key_number: "KEY-7712-B",
    full_name: "Alexander M. Thorne",
    email: "a.thorne@academic.edu",
    status: "confirmed",
    created_at: DateTime.new(2026, 10, 24, 10, 14, 0)
  },
  {
    key_number: "KEY-8824-A",
    full_name: "Dr. Eleanor Vance, M.Sc.",
    email: "e.vance@state-inst.org",
    status: "confirmed",
    created_at: DateTime.new(2026, 10, 24, 11, 30, 0)
  },
  {
    key_number: "KEY-9102-C",
    full_name: "Marcus Chen",
    email: "m.chen@polymetric.io",
    status: "pending_review",
    created_at: DateTime.new(2026, 10, 25, 14, 28, 10)
  },
  {
    key_number: "KEY-3301-D",
    full_name: "Sophia Kowalski",
    email: "sophia.k@warsaw-inst.eu",
    status: "confirmed",
    created_at: DateTime.new(2026, 10, 25, 16, 50, 4)
  },
  {
    key_number: "KEY-5542-E",
    full_name: "David O. Adeleke",
    email: "d.adeleke@lagos-tech.ng",
    status: "pending_review",
    created_at: DateTime.new(2026, 10, 26, 8, 11, 39)
  }
]

students_data.each do |data|
  reg = course.registrations.find_or_initialize_by(key_number: data[:key_number])
  reg.assign_attributes(
    full_name: data[:full_name],
    email: data[:email],
    status: data[:status],
    created_at: data[:created_at] || Time.current
  )
  reg.save!
  puts "  -> Seeded Registration: #{reg.key_number} | #{reg.full_name} [#{reg.status}]"
end

puts "== Seeding Complete =="
