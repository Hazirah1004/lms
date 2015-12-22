class AddCompasleaveFromEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :compasleave, :integer
  end
end
