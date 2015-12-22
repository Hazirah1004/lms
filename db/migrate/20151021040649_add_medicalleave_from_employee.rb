class AddMedicalleaveFromEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :medicalleave, :integer
  end
end
