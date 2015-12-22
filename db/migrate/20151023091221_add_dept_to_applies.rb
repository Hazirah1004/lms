class AddDeptToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :dept, :integer
  end
end
