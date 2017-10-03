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


  # ************************** #
  # API
  # ************************** #
  def create
    authorize! :create_blog, :post

    post = Post.new
    post.user_id = current_user.id
    post.is_available = true
    post.is_show = false
    post.is_home = false
    post.setData(params)
    post.save

    post.link = Tool.unaccent(params[:name].gsub(' ', '-')).downcase.to_s
    post.link += '-'+post.id.to_s
    post.save

    # TODO: Cover URL
    redirect_to action: 'index'
  end

end
