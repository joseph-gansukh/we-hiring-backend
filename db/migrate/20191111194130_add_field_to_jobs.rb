class AddFieldToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :field, :string
  end
end
