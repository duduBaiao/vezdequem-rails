class AddLastDatesToRecords < ActiveRecord::Migration
  def change
  	add_column :records, :last_payment, :datetime
  	add_column :records, :last_taking, :datetime

  	add_column :records, :last_paid, :decimal, default: 0, null: false, precision: 8, scale: 2
  	add_column :records, :last_taken, :decimal, default: 0, null: false, precision: 8, scale: 2
  end
end
