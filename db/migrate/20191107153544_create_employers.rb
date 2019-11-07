class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :field
      t.string :location

      t.timestamps
    end
  end
end
