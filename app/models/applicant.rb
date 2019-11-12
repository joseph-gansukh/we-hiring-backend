class Applicant < ApplicationRecord
  has_many :job_applicants
  has_many :jobs, through: :job_applicants
  has_secure_password
  

  def to_param
    name
  end
end
