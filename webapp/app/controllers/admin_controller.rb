class AdminController < ApplicationController
  before_action :authenticate_user!


  # ************************** #
  # Layout
  # ************************** #

  def list_user
    authorize! :list_user, :profile

    @search = params[:search]
    if @search.present?
      wildcard_search = "%#{@search}%"
      @users = User::where("name LIKE ? OR email LIKE ?", wildcard_search, wildcard_search).order(created_at: :desc).page(params[:page]).per(20)
    else
      @users = User::order(created_at: :desc).page(params[:page]).per(20)
    end

    @pageType = 'list_user'
    render :'list_user', status: :ok, :layout => 'profile'
  end

  def edit_user
    authorize! :edit_user, :profile

    @user = User::find(params[:id])

    render :'edit_user', status: :ok, :layout => 'profile'
  end

  def list_project
    authorize! :list_project, :profile

    @search = params[:search]
    if @search.present?
      wildcard_search = "%#{@search}%"
      @projects = Project::where("name LIKE ? OR address LIKE ?", wildcard_search, wildcard_search).where(:is_available => true).order(created_at: :desc).page(params[:page]).per(20)
    else
      @projects = Project::where(:is_available => true).order(created_at: :desc).page(params[:page]).per(20)
    end

    @pageType = 'list_project'
    render :'list_project', status: :ok, :layout => 'profile'
  end

  def edit_project
    authorize! :edit_project, :profile

    @project = Project::find(params[:id])

    render :'edit_project', status: :ok, :layout => 'profile'
  end

  def new_project
    authorize! :new_project, :profile

    render :'new_project', status: :ok, :layout => 'profile'
  end

  # ************************** #
  # API
  # ************************** #

  def edit_role
    authorize! :edit_role, :profile
    response = Response.new(Constant::MESSAGE_SUCCESS, Constant::STATUS_CODE_SUCCESS)

    userId = params[:id]
    roleUser = RoleUser::where(:user_id => userId).first

    role = Role::where(:name => params[:role]).first
    roleUser.role_id = role.id
    roleUser.save

    render json: response
  end

  def put_user
    authorize! :put_user, :profile

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

    redirect_to controller: 'admin', action: 'edit_user', id: user.id
  end

  def status_post
    authorize! :status_post, :profile
    response = Response.new(Constant::MESSAGE_SUCCESS, Constant::STATUS_CODE_SUCCESS)

    house = House::find(params[:id])
    status = params[:status]
    house.status = status
    house.save

    render json: response
  end

  def is_home_post
    authorize! :status_post, :profile
    response = Response.new(Constant::MESSAGE_SUCCESS, Constant::STATUS_CODE_SUCCESS)

    house = House::find(params[:id])
    status = params[:status]
    if status == 'true'
      house.is_home = true
    else
      house.is_home = false
    end
    house.save

    render json: response
  end

  def is_home_user
    authorize! :status_post, :profile
    response = Response.new(Constant::MESSAGE_SUCCESS, Constant::STATUS_CODE_SUCCESS)

    user = User::find(params[:id])
    status = params[:status]
    if status == 'true'
      user.is_home = true
    else
      user.is_home = false
    end
    user.save

    render json: response
  end

  def is_home_project
    authorize! :status_post, :profile
    response = Response.new(Constant::MESSAGE_SUCCESS, Constant::STATUS_CODE_SUCCESS)

    project = Project::find(params[:id])
    status = params[:status]
    if status == 'true'
      project.is_home = true
    else
      project.is_home = false
    end
    project.save

    render json: response
  end

  def put_project
    authorize! :put_project, :profile

    project = Project::find(params[:id])
    project.save_data(params)

    redirect_to controller: 'admin', action: 'list_project'
  end

  def post_project
    authorize! :post_project, :profile

    project = Project.new
    project.save_data(params)
    redirect_to controller: 'admin', action: 'list_project'
  end

  def delete_project
    authorize! :delete_project, :profile
    response = Response.new(Constant::MESSAGE_SUCCESS, Constant::STATUS_CODE_SUCCESS)

    project = Project::find(params[:id])
    project.is_available = false
    project.save

    render json: response
  end

end
