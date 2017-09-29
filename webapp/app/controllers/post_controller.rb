class PostController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!
  layout 'profile'

  # ************************** #
  # Layout
  # ************************** #

  def new
    authorize! :new_blog, :post

    @pageType = 'new_blog'
  end

  def index
    authorize! :list_blog, :post

    # Check role admin
    roleUser = RoleUser.where(:user_id => current_user.id).first
    @role = Role.find(roleUser.role_id)

    if @role.name == Constant::ROLE_ADMIN
      @posts = Post::order(sort_by).page(params[:page]).per(20)
    else
      @posts = Post::where(:user_id => current_user.id).order(sort_by).page(params[:page]).per(20)
    end

    @pageType = 'list_blog'
  end
end
