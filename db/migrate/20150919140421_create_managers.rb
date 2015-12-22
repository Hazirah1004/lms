class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.integer :employee_id
      t.integer :dept_id

      t.timestamps null: false
    end
  end
end
