class JobApplicant < ApplicationRecord
  belongs_to :job
  belongs_to :applicant
end
