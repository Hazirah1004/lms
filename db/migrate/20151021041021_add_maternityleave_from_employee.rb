class AddMaternityleaveFromEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :maternityleave, :integer
  end
end
