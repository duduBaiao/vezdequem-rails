class AddChooseTakersToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :choose_takers, :boolean
  end
end
