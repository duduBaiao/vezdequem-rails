class AddPurposeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :purpose, :string, default: :ammount
  end
end
