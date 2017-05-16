class AddCountersToRecords < ActiveRecord::Migration
  def change
  	add_column :records, :paid_count, :integer, default: 0, null: false
  	add_column :records, :taken_count, :integer, default: 0, null: false
  end
end
