require 'openssl'

class AdminController < ApplicationController
  include Responses
  before_action :authenticate_user!, except: [:callback_budget, :webhook_github]
  skip_before_action :verify_authenticity_token, only: [:callback_budget, :webhook_github]

  # ************************** #
  # Layout
  # ************************** #

  def list_user

    if params[:search].present?
      @users = User.search(params[:search], params[:page], 20)
    else
      @users = User.by_desc_order(params[:page], params[:per_page])
    end

    @pageType = 'list_user'
    render :list_user, status: :ok, :layout => 'profile'
  end

  def edit_user
    authorize! :edit_user, :admin

    @user = User::find(params[:id])

    render :edit_user, status: :ok, :layout => 'profile'
  end

  def list_project
    authorize! :list_project, :admin

    if params[:search].present?
      @projects = Project.search(params[:search], params[:page], 20)
    else
      @projects = Project.by_desc_order(params[:page], params[:per_page])
    end

    @pageType = 'list_project'
    render :list_project, status: :ok, :layout => 'profile'
  end

  def edit_project
    authorize! :edit_project, :admin

    @project = Project::find(params[:id])

    render :edit_project, status: :ok, :layout => 'profile'
  end

  def new_project
    authorize! :new_project, :admin

    render :new_project, status: :ok, :layout => 'profile'
  end

  def edit_project_photo
    authorize! :edit_photo, :admin

    @project = Project.where(:id => params[:id]).first

    @pageType = 'edit_project_photo'
    render :edit_project_photo, status: :ok, :layout => 'profile'
  end

  # ************************** #
  # API
  # ************************** #

  def edit_role
    authorize! :edit_role, :admin
    userId = params[:id]
    roleUser = RoleUser::where(:user_id => userId).first

    role = Role::where(:name => params[:role]).first
    roleUser.role_id = role.id
    roleUser.save

    render json: response_success
  end

  def put_user
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

    redirect_to controller: 'admin', action: 'edit_user', id: user.id
  end

  def status_post
    authorize! :status_post, :admin

    house = House::find(params[:id])
    status = params[:status]
    house.status = status
    house.save

    render json: response_success

  end

  def is_home_post
    authorize! :status_post, :admin

    house = House::find(params[:id])
    status = params[:status]
    if status == 'true'
      house.is_home = true
    else
      house.is_home = false
    end
    house.save

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

  def is_home_project
    authorize! :status_post, :admin

    project = Project::find(params[:id])
    status = params[:status]
    if status == 'true'
      project.is_home = true
    else
      project.is_home = false
    end
    project.save

    render json: response_success
  end

  def put_project
    authorize! :put_project, :admin
    userId = current_user.id

    project = Project::find(params[:id])
    project.save_data(params)

    if Photo.create_project_photo(project, userId, params)
      redirect_to action: 'edit_project_photo', id: project.id
    else
      redirect_to controller: 'admin', action: 'list_project'
    end
  end

  def post_project
    authorize! :post_project, :admin
    userId = current_user.id

    project = Project.new
    project.save

    project.link = Tool.unaccent(params[:name].gsub(' ', '-')).downcase.to_s
    project.link += '-'+project.id.to_s

    project.save_data(params)

    if Photo.create_project_photo(project, userId, params)
      redirect_to action: 'edit_project_photo', id: project.id
    else
      redirect_to controller: 'admin', action: 'list_project'
    end
  end

  def put_project_photo
    authorize! :put_photo, :admin
    project = Project::find(params[:id])

    # Photo description
    if (params[:imagedest]).present?
      (params[:imagedest]).each_with_index do |imagedest, index|
        photo = project.photos[index]
        photo.description = imagedest
        photo.save
      end
    end

    redirect_to controller: 'admin', action: 'list_project'
  end

  def delete_project
    authorize! :delete_project, :admin

    project = Project::find(params[:id])
    project.is_available = false
    project.save

    render json: response_success
  end

  def callback_budget
    serverKey = params[:server_key]
    responseCode = params[:vpc_TxnResponseCode].to_i

    if serverKey == Constant::ONEPAY_SERVER_KEY and responseCode == 0

      amount = params[:vpc_Amount].to_i
      merchTxnRef = params[:vpc_MerchTxnRef]
      userId = merchTxnRef.split('_')[0]

      user = User::find(userId)
      user.budget += amount/100
      user.save

      render json: response_success
    else
      render json: response_failure
    end

  end

  def webhook_github
    if params[:token].to_s == Constant::WEBHOOK_TOKEN
      # json_body = JSON.parse(request.body.read)
      json_body = JSON.parse(params[:payload])
      if json_body['ref'].present?
        branch = json_body['ref'].split('/').last
        if branch.to_s == Constant::BRANCH_MASTER
          # Create new webhook
          webhook = Webhook.new
          webhook.save
          webhook.update_script
        end
      end
      render json: response_success
    else
      render json: response_failure
    end
  end

end
