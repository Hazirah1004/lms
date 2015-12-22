class AddStatusToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :status, :string
  end
end
