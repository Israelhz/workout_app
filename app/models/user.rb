class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exercises

  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User', foreign_key: "friend_id"
  has_one :room
  has_many :messages

  validates :first_name, :last_name, presence: true
  after_create :create_chatroom

  self.per_page = 10

  def self.search_by_name(name)
    names_array = name.split(" ")

    if names_array.size == 1
      where('first_name LIKE ? or last_name LIKE ?',
        "%#{names_array.first}%", "%#{names_array.first}%").order(:first_name)
    else
      where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ? or last_name LIKE ?',
        "%#{names_array.first}%", "%#{names_array.second}%",
        "%#{names_array.first}%", "%#{names_array.second}%").order(:first_name)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end

  def current_friendship(friend)
    friendships.where(friend: friend).first
  end

  private

  def create_chatroom
    hyphenated_username = self.full_name.split.join('-')
    Room.create(name: hyphenated_username, user_id: self.id)
  end
end
