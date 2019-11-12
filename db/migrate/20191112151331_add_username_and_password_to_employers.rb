class AddUsernameAndPasswordToEmployers < ActiveRecord::Migration[6.0]
  def change
    add_column :employers, :username, :string
    add_column :employers, :password_digest, :string
  end
end
