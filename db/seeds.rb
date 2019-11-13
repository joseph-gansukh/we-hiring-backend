# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employer = Employer.create(name: 'FlatIron', field: "School", location: "Chicago", usertype: 'employer')
job = Job.create(title: "React Developer", description: "make websites in React", employer_id: 1)
applicant = Applicant.create(name: "Laura", location: "Chicago", username: "laura", password_digest: 'laura', usertype: 'applicant')
jobapplicant = JobApplicant.create(job_id: 1, applicant_id: 1)
