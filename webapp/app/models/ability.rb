class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role(Constant::ROLE_ADMIN,user.id)
      can :manage, :all
    elsif user.role(Constant::ROLE_AGENT,user.id)
      can [:list_house, :new_house, :edit_house, :edit_photo, :post_house, :put_house, :delete_house, :put_photo, :edit_profile, :show_budget, :list_bookmark, :toggle_bookmark, :delete_bookmark], :profile
      can [:delete_photo], :photo
    elsif user.role(Constant::ROLE_GUEST,user.id)

    else
      can :create, User
    end
  end
end
