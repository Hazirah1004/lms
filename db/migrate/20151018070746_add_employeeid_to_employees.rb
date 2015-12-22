class AddEmployeeidToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :employeeid, :string
  end
end
