class AddUsernameAndPasswordToApplicants < ActiveRecord::Migration[6.0]
  def change
    add_column :applicants, :username, :string
    add_column :applicants, :password_digest, :string
  end
end
