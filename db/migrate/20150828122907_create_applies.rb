class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.integer :leave_type
      t.date :start_date
      t.date :end_date
      t.integer :replace_person
      t.text :address_on_leave

      t.timestamps null: false
    end
  end
end
