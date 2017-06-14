require 'rest-client'

class ProfileController < ApplicationController
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

    @pageType = 'edit_house'
    render :'edit_house', status: :ok, :layout => 'profile'
  end

  def list_house
    authorize! :list_house, :profile

    # Check role admin
    roleUser = RoleUser.where(:user_id => current_user.id).first
    @role = Role.find(roleUser.role_id)

    @search = params[:search]
    if @search.present?
      wildcard_search = "%#{@search}%"
      if @role.name == Constant::ROLE_ADMIN
        @houses = House::where("name LIKE ? OR address LIKE ?", wildcard_search, wildcard_search).where(:is_available => true).order(created_at: :desc).page(params[:page]).per(20)
      else
        @houses = House::where("name LIKE ? OR address LIKE ?", wildcard_search, wildcard_search).where(:user_id => current_user.id).where(:is_available => true).order(created_at: :desc).page(params[:page]).per(20)
      end
    else
      if @role.name == Constant::ROLE_ADMIN
        @houses = House::where(:is_available => true).order(created_at: :desc).page(params[:page]).per(20)
      else
        @houses = House::where(:user_id => current_user.id).where(:is_available => true).order(created_at: :desc).page(params[:page]).per(20)
      end
    end

    @pageType = 'list_house'
    render :'list_house', status: :ok, :layout => 'profile'
  end

  def edit_profile
    @pageType = 'edit_profile'
    render :'edit_profile', status: :ok, :layout => 'profile'
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
    house.link = Tool.unaccent(params[:name].gsub(' ', '-')).downcase.to_s
    house.link += '-'+house.id.to_s

    house.save_house(house, params)
    Photo.create_photo(house, userId, params)
    Contract.create_contract(house, userId)

    redirect_to action: 'list_house'
  end

  def put_house
    authorize! :put_house, :profile
    userId = current_user.id

    house = House::find(params[:id])
    # clear houseFurniture and houseConvenience
    HouseConvenience::where(:house_id => house.id).destroy_all
    HouseFurniture::where(:house_id => house.id).destroy_all

    house.save_house(house, params)
    Photo.create_photo(house, userId, params)

    redirect_to action: 'list_house'
  end


  def delete_house
    authorize! :delete_house, :profile
    response = Response.new(Constant::MESSAGE_FAIL, Constant::STATUS_CODE_FAIL)

    house = House::find(params[:id])
    userId = current_user.id
    if userId == house.user_id
      house.is_available = false
      house.save

      response.set_message(Constant::MESSAGE_SUCCESS)
      response.set_status_code(Constant::STATUS_CODE_SUCCESS)
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
