class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :ic
      t.text :address
      t.string :phone
      t.string :position
      t.string :email
      t.integer :dept
      t.date :startdate

      t.timestamps null: false
    end
  end
end
