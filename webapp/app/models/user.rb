class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]


  ROLES = {0 => :default, 1 => :admin}

  def self.from_omniauth_facebook(auth)
    email = auth.info.email
    user = User.where(:email => email).first if email

    if user == nil
      user = User.new
      if email
        user.email = auth.info.email
      else
        user.email = ''
      end
      user.password = Devise.friendly_token[0, 20]
      user.token = Devise.friendly_token[0, 20]
      user.user_ts = Time.current
      user.confirmed_at = Time.current
    end

    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name # assuming the user model has a name
    user.avatar = auth.info.image + '?type=large' # assuming the user model has an image
    user.save!

    user.skip_confirmation!
    return user

  end

  def self.from_omniauth_google(auth)
    email = auth.info.email
    user = User.where(:email => email).first if email

    if user == nil
      user = User.new
      if email
        user.email = auth.info.email
      else
        user.email = ''
      end
      user.password = Devise.friendly_token[0, 20]
      user.token = Devise.friendly_token[0, 20]
      user.user_ts = Time.current
      user.confirmed_at = Time.current
    end

    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name # assuming the user model has a name
    user.avatar = auth.info.image # assuming the user model has an image
    user.save!

    user.skip_confirmation!
    return user
  end


  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
