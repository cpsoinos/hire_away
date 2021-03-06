class User < ActiveRecord::Base
  has_many :offers
  has_many :calls
  has_many :positions, through: :calls
  has_many :events, through: :offers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2]

  def timeout_in
    # in line with Google OAuth timeout for calendar writing
    1.hour
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == "admin"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.full_name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(email: data["email"]).first
    if user.admin?
      user.provider = access_token.provider
      user.uid = access_token.uid
      user.token = access_token.credentials.token
      user.save
    end
    user
  end
end
