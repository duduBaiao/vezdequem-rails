class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
    	t.references :group, null: false
    	t.references :user, null: false

    	t.decimal  :taken, default: 0, null: false, precision: 8, scale: 2
    	t.decimal  :paid, default: 0, null: false, precision: 8, scale: 2

    	t.boolean  :enabled, default: true, null: false

    	t.timestamps null: false
    end

    add_foreign_key :records, :groups
    add_foreign_key :records, :users
  end
end
