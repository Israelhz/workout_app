class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exercises

  validates :first_name, :last_name, presence: true

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
end
