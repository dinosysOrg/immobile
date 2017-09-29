class UserController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!
  layout 'profile'

  # ************************** #
  # Layout
  # ************************** #
  def index
    if params[:search].present?
      @users = User.search(sort_by, params[:search], params[:page], 20)
    else
      @users = User.by_order(sort_by, params[:page], params[:per_page])
    end

    @pageType = 'list_user'
  end

  def edit
    authorize! :edit_user, :admin

    @user = User::find(params[:id])
  end

  # ************************** #
  # API
  # ************************** #

  def update
    authorize! :put_user, :admin

    user = User::find(params[:id])
    user.name = params[:name]
    user.address = params[:address]
    user.phone = params[:phone]
    user.skype = params[:skype]
    user.save

    # avatar update
    if params[:img].present?
      avatar = Photo.create_avatar(user.id, params)
      user.avatar = avatar
      user.save
    end

    redirect_to action: 'edit', id: user.id
  end

  def edit_role_user
    authorize! :edit_role, :admin

    userId = params[:id]
    roleUser = RoleUser::where(:user_id => userId).first

    role = Role::where(:name => params[:role]).first
    roleUser.role_id = role.id
    roleUser.save

    render json: response_success
  end

  def is_home_user
    authorize! :status_post, :admin

    user = User::find(params[:id])
    status = params[:status]
    if status == 'true'
      user.is_home = true
    else
      user.is_home = false
    end
    user.save

    render json: response_success
  end

end
