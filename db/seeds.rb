# This file should ensure the existence of records required to run the application in every environment (production,
# development, test).

puts "Cleaning database..."
VerificationCase.destroy_all
WorkHistory.destroy_all
EducationHistory.destroy_all
Candidate.destroy_all
Organization.destroy_all
Admin.destroy_all

puts "Creating admin user..."
Admin.create!(
  email: "admin@truebg.com",
  password: "password123"
)

puts "Creating organizations..."
organizations = []
5.times do
  organizations << Organization.create!(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    website: "https://#{Faker::Internet.domain_name}"
  )
end

puts "Creating candidates and verification cases..."
15.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  candidate = Candidate.create!(
    first_name: first_name,
    last_name: last_name,
    email: Faker::Internet.unique.email(name: "#{first_name} #{last_name}"),
    password: "password123",
    phone: Faker::PhoneNumber.cell_phone,
    dob: Faker::Date.birthday(min_age: 22, max_age: 50),
    pan_number: Faker::IdNumber.brazilian_id, # Using as proxy for PAN
    aadhaar_number: Faker::Number.number(digits: 12).to_s,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    pincode: Faker::Address.zip_code
  )

  # Add some work history
  rand(1..3).times do
    WorkHistory.create!(
      candidate: candidate,
      company_name: Faker::Company.name,
      job_title: Faker::Job.title,
      start_date: Faker::Date.backward(days: 365 * 5),
      end_date: Faker::Date.backward(days: 30),
      current_job: [ true, false ].sample,
      location: Faker::Address.city,
      verified: [ true, false ].sample
    )
  end

  # Add education
  EducationHistory.create!(
    candidate: candidate,
    institution_name: "#{Faker::University.name} University",
    degree: [ "Bachelor of Science", "Master of Arts", "PhD", "MBA" ].sample,
    field_of_study: Faker::Educator.subject,
    graduation_year: Faker::Number.between(from: 2010, to: 2023),
    verified: [ true, false ].sample
  )

  # Create a verification case
  status = VerificationCase::STATUSES.sample
  VerificationCase.create!(
    candidate: candidate,
    organization: organizations.sample,
    status: status,
    requested_at: Faker::Time.backward(days: 30),
    completed_at: status == "completed" ? Faker::Time.backward(days: 5) : nil
  )
end

puts "Seed completed!"
puts "Created #{Organization.count} organizations"
puts "Created #{Candidate.count} candidates"
puts "Created #{VerificationCase.count} verification cases"
