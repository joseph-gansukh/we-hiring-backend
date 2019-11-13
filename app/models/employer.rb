class Employer < ApplicationRecord
  has_many :jobs
  has_secure_password
  
  def to_param
    name
  end
  
end
