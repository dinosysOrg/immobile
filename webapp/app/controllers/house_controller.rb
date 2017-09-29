class HouseController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!
  layout 'profile'

  # ************************** #
  # Layout
  # ************************** #

  def new
    authorize! :new_house, :profile

    @pageType = 'new_house'
  end

  def edit
    authorize! :edit_house, :profile

    @house = House::where(:link => params[:link]).first
    @contract = Contract.where(:house_id => @house.id).first

    @pageType = 'edit_house'
  end

  def edit_photo
    authorize! :edit_photo, :profile

    @house = House.where(:link => params[:link]).first

    @pageType = 'edit_photo'
    render :edit_photo, status: :ok, :layout => 'profile'
  end

  def index
    authorize! :list_house, :profile

    # Check role admin
    roleUser = RoleUser.where(:user_id => current_user.id).first
    @role = Role.find(roleUser.role_id)

    if params[:search].present?
      if @role.name == Constant::ROLE_ADMIN
        @houses = House.search(sort_by, params[:search], params[:page], 20)
      else
        @houses = House.search(sort_by, params[:search], params[:page], 20, current_user.id)
      end
    else
      if @role.name == Constant::ROLE_ADMIN
        @houses = House.where(:is_available => true).order(sort_by).page(params[:page]).per(20)
      else
        @houses = House.where(:user_id => current_user.id).where(:is_available => true).order(sort_by).page(params[:page]).per(20)
      end
    end

    @pageType = 'list_house'
  end


  # ************************** #
  # API
  # ************************** #

  def create
    authorize! :post_house, :profile
    userId = current_user.id

    house = House.new
    house.user_id = userId
    house.is_available = true

    house.disable_at = Time.strptime(params[:disable_at], '%m/%d/%Y')
    house.save_house(house, params)

    house.link = Tool.unaccent(params[:name].gsub(' ', '-')).downcase.to_s
    house.link += '-'+house.id.to_s
    house.save

    contract = Contract.create_contract(house, userId)
    contract.add_service(house, params, current_user)

    if Photo.create_photo(house, userId, params)
      redirect_to action: 'edit_photo', link: house.link
    else
      redirect_to action: 'index'
    end
  end

  def update
    authorize! :put_house, :profile
    userId = current_user.id

    house = House.find(params[:id])
    # clear houseFurniture and houseConvenience
    HouseConvenience.where(:house_id => house.id).destroy_all
    HouseFurniture.where(:house_id => house.id).destroy_all

    # clear services and add new
    # contract = Contract::where(:house_id => house.id).first
    # if contract.present?
    #   contract.contract_services.destroy_all
    #   contract.add_service(params)
    # end

    house.save_house(house, params)
    if Photo.create_photo(house, userId, params)
      redirect_to action: 'edit_photo', link: house.link
    else
      redirect_to action: 'index'
    end
  end

  def delete
    authorize! :delete_house, :profile
    response = response_failure

    house = House.find(params[:id])
    userId = current_user.id
    if userId == house.user_id or current_user.check_role(Constant::ROLE_ADMIN)
      house.is_available = false
      house.save

      response = response_success
    end

    render json: response
  end

  def create_photo
    authorize! :put_photo, :profile

    house = House::find(params[:id])
    # Photo description

    if (params[:imagedest]).present?
      (params[:imagedest]).each_with_index do |imagedest, index|
        photo = house.photos[index]
        photo.description = imagedest
        photo.save
      end
    end

    redirect_to action: 'list_house'
  end


  # ************************** #
  # Admin Api
  # ************************** #

  def status_post
    authorize! :status_post, :admin

    house = House::find(params[:id])
    status = params[:status]
    house.status = status
    house.save

    if house.status == Constant::HOUSE_STATUS_APPROVE
      house.deduct_wallet
    end

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

end
