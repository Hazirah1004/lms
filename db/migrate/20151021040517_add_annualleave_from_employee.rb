class AddAnnualleaveFromEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :annualleave, :integer
  end
end
