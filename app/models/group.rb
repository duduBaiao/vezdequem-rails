class Group < ActiveRecord::Base

  has_many :users, through: :records

  has_many :records, autosave: true

  before_save do
  	if self.choose_takers.nil?
  		self.choose_takers = (self.purpose == "ammount")
  	end
  	true
  end

  def self.new_by_user(user, group_params)
  	group = Group.new(group_params)
  	group.records << Record.new(user: user)

  	group
  end

end
