class BookmarkController < ApplicationController
  include Responses
  include Sortby

  before_action :authenticate_user!
  layout 'profile'

  def index
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
  end


  # ************************** #
  # API
  # ************************** #

  def update
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

  def destroy
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
