class AddTypeToEmployers < ActiveRecord::Migration[6.0]
  def change
    add_column :employers, :usertype, :string
  end
end
