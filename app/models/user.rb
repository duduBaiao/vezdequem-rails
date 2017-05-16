class User < ActiveRecord::Base
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups, through: :records

  has_many :active_groups, -> { where(records: {enabled: true}) }, through: :records, source: :group

  has_many :records

  validates :nick_name, presence: true

  def self.random_password()
    (('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a).sort_by { rand }.join[0...6]
  end
end
