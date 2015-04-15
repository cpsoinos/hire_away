class User < ActiveRecord::Base
  has_many :offers
  # has_many :calls, through: :offers
  has_many :positions, through: :calls
  has_many :events, through: :offers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == "admin"
  end
end
