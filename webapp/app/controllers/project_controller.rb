class ProjectController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!
  layout 'profile'

  # ************************** #
  # Layout
  # ************************** #

  def index
    authorize! :list_project, :admin

    if params[:search].present?
      @projects = Project.search(sort_by, params[:search], params[:page], 20)
    else
      @projects = Project.by_order(sort_by, params[:page], params[:per_page])
    end

    @pageType = 'list_project'
  end

  def edit
    authorize! :edit_project, :admin

    @project = Project::find(params[:id])
  end

  def new
    authorize! :new_project, :admin
  end

  def edit_photo
    authorize! :edit_photo, :admin

    @project = Project.where(:id => params[:id]).first

    @pageType = 'edit_project_photo'
    render :edit_project_photo, status: :ok, :layout => 'profile'
  end

  # ************************** #
  # API
  # ************************** #

  def update
    authorize! :put_project, :admin
    userId = current_user.id

    project = Project::find(params[:id])
    project.save_data(params)

    if Photo.create_project_photo(project, userId, params)
      redirect_to action: 'edit_project_photo', id: project.id
    else
      redirect_to action: 'index'
    end
  end

  def create
    authorize! :post_project, :admin
    userId = current_user.id

    project = Project.new
    project.save_data(params)

    project.link = Tool.unaccent(params[:name].gsub(' ', '-')).downcase.to_s
    project.link += '-'+project.id.to_s
    project.save

    if Photo.create_project_photo(project, userId, params)
      redirect_to action: 'edit_project_photo', id: project.id
    else
      redirect_to action: 'index'
    end
  end

  def destroy
    authorize! :delete_project, :admin

    project = Project::find(params[:id])
    project.is_available = false
    project.save

    render json: response_success
  end

  def create_photo
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

    redirect_to action: 'index'
  end

  def is_home
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

end
