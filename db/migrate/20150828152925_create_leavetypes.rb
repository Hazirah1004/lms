class CreateLeavetypes < ActiveRecord::Migration
  def change
    create_table :leavetypes do |t|
      t.text :ltype

      t.timestamps null: false
    end
  end
end
