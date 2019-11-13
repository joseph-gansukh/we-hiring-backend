class AddTypeToApplicants < ActiveRecord::Migration[6.0]
  def change
    add_column :applicants, :usertype, :string
  end
end
