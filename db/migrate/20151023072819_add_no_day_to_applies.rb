class AddNoDayToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :no_day, :integer
  end
end
