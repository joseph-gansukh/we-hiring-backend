class Job < ApplicationRecord
  belongs_to :employer
  has_many :job_applicants 
  has_many :applicants, through: :job_applicants
end
