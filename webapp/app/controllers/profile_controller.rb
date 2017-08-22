require 'rest-client'

class ProfileController < ApplicationController
  include Responses
  before_action :authenticate_user!

  # ************************** #
  # Layout
  # ************************** #

  def new_house
    authorize! :new_house, :profile

    @pageType = 'new_house'
    render :'new_house', status: :ok, :layout => 'profile'
  end

  def edit_house
    authorize! :edit_house, :profile

    @house = House::where(:link => params[:link]).first
    @contract = Contract.where(:house_id => @house.id).first

    @pageType = 'edit_house'
    render :'edit_house', status: :ok, :layout => 'profile'
  end

  def edit_photo
    authorize! :edit_photo, :profile

    @house = House.where(:link => params[:link]).first

    @pageType = 'edit_photo'
    render :edit_photo, status: :ok, :layout => 'profile'
  end

  def list_house
    authorize! :list_house, :profile

    # Check role admin
    roleUser = RoleUser.where(:user_id => current_user.id).first
    @role = Role.find(roleUser.role_id)

    if params[:search].present?
      if @role.name == Constant::ROLE_ADMIN
        @houses = House.search(params[:search], params[:page], 20)
      else
        @houses = House.search(params[:search], params[:page], 20, current_user.id)
      end
    else
      if @role.name == Constant::ROLE_ADMIN
        @houses = House.where(:is_available => true).order(created_at: :desc).page(params[:page]).per(20)
      else
        @houses = House.where(:user_id => current_user.id).where(:is_available => true).order(created_at: :desc).page(params[:page]).per(20)
      end
    end

    @pageType = 'list_house'
    render :list_house, status: :ok, :layout => 'profile'
  end

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
  # ************************** #
  # API
  # ************************** #

  def post_house
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
      redirect_to action: 'list_house'
    end
  end

  def put_house
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
      redirect_to action: 'list_house'
    end
  end

  def put_photo
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


  def delete_house
    authorize! :delete_house, :profile
    response = response_failure

    house = House.find(params[:id])
    userId = current_user.id
    if userId == house.user_id
      house.is_available = false
      house.save

      response = response_failure
    end

    render json: response
  end

  def put_profile
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


end
