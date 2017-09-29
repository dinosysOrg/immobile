require 'rest-client'

class ProfileController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!


  def edit_profile
    authorize! :edit_profile, :profile

    @pageType = 'edit_profile'
    render :edit_profile, status: :ok, :layout => 'profile'
  end

  def show_budget
    authorize! :show_budget, :profile

    @pageType = 'budget_profile'
    render :budget_profile, status: :ok, :layout => 'profile'
  end

  def list_bookmark
    authorize! :list_bookmark, :profile

    # Check role admin
    roleUser = RoleUser.where(:user_id => current_user.id).first
    @role = Role.find(roleUser.role_id)

    if @role.name == Constant::ROLE_ADMIN
      @bookmarks = Bookmark::order(sort_by).page(params[:page]).per(20)
    else
      @bookmarks = Bookmark::where(:user_id => current_user.id).order(sort_by).page(params[:page]).per(20)
    end


    @pageType = 'list_bookmark'
    render :list_bookmark, status: :ok, :layout => 'profile'
  end

  # ************************** #
  # API
  # ************************** #

  def put_profile
    authorize! :edit_profile, :profile

    current_user.name = params[:name]
    current_user.address = params[:address]
    current_user.phone = params[:phone]
    current_user.skype = params[:skype]
    current_user.save

    # avatar update
    if params[:img].present?
      avatar = Photo.create_avatar(current_user.id, params)
      current_user.avatar = avatar
      current_user.save
    end

    redirect_to action: 'edit_profile'
  end

  def toggle_bookmark
    authorize! :toggle_bookmark, :profile

    bookmark = Bookmark::where(:user_id => current_user.id).where(:object_id => params[:object_id]).where(:provider => params[:provider]).first
    if bookmark.present?
      bookmark.delete
    else
      bookmark = Bookmark.new
      bookmark.user_id = current_user.id
      bookmark.save_data(params)
    end

    render json: response_success
  end

  def delete_bookmark
    authorize! :delete_bookmark, :profile
    response = response_failure

    bookmark = Bookmark::find(params[:id])
    if bookmark.user_id == current_user.id || current_user.check_role(Constant::ROLE_ADMIN)
      bookmark.delete
      response = response_success
    end
    render json: response
  end


end
