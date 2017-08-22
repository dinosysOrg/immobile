class User < ActiveRecord::Base
  include Search
  scope :by_order, -> (sort_by, page, per_page) { order(sort_by).page(page).per(per_page) }
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
      user.confirmed_at = Time.current
    end

    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name # assuming the user model has a name
    user.avatar = auth.info.image + '?type=large' # assuming the user model has an image
    user.save!

    user.create_role
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
      user.confirmed_at = Time.current
    end

    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name # assuming the user model has a name
    user.avatar = auth.info.image # assuming the user model has an image
    user.save!

    user.create_role
    user.skip_confirmation!
    return user
  end


  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.search(sort_by, search_param, page_param, per_page)
    wildcard_search = "%#{search_param}"
    by_wildcard_with_name_or_email_or_phone(wildcard_search)
    .order(sort_by)
    .page(page_param).per(per_page)
  end

  def role(roleName, userID)
    accept = false
    @listRole = RoleUser.where(:user_id => userID.to_i)
    unless @listRole.nil? && @listRole.size > 0
      @listRole.each do |item|

        @role = Role.find(item.role_id.to_i)

        unless @role.nil?
          if @role.name == roleName
            accept = true
          end
        end

      end
    end
    return accept
  end

  def check_role(roleName)
    accept = false
    @listRole = RoleUser.where(:user_id => self.id)
    unless @listRole.nil? && @listRole.size > 0
      @listRole.each do |item|

        @role = Role.find(item.role_id.to_i)

        unless @role.nil?
          if @role.name == roleName
            accept = true
          end
        end

      end
    end
    return accept
  end

  def create_role
    roleUser = RoleUser.where(:user_id => self.id).first
    unless roleUser.nil?
      return
    end

    roleUser = RoleUser.new
    roleUser.user_id = self.id

    if self.email == 'quytruong1991@gmail.com'
      role = Role.where(:name => Constant::ROLE_ADMIN).first
      roleUser.role_id = role.id
    else
      role = Role.where(:name => Constant::ROLE_AGENT).first
      roleUser.role_id = role.id
    end
    roleUser.save()
  end
end
