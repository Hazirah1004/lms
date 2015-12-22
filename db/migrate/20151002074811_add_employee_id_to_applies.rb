class AddEmployeeIdToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :employee_id, :integer
  end
end
