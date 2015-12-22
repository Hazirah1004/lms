class AddHashedPasswordToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :hashed_password, :string
  end
end
