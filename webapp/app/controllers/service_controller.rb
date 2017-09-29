class ServiceController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!
  layout 'profile'

  # ************************** #
  # Layout
  # ************************** #

  def index
    authorize! :list_services, :admin

    if params[:search].present?
      @services = Service.search(sort_by, params[:search], params[:page], 20)
    else
      @services = Service.by_order(sort_by, params[:page], params[:per_page])
    end

    @pageType = 'list_service'
  end

  def edit
    authorize! :edit_service, :admin

    @service = Service::find(params[:id])
  end

  # ************************** #
  # API
  # ************************** #

  def update
    authorize! :put_service, :admin
    service = Service::find(params[:id])
    service.save_data(params)

    redirect_to action: 'index'
  end
end
