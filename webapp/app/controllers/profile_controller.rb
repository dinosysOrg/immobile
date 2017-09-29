require 'rest-client'

class ProfileController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!
  layout 'profile'


  def edit
    authorize! :edit_profile, :profile

    @pageType = 'edit_profile'
  end

  # ************************** #
  # API
  # ************************** #

  def update
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

    redirect_to action: 'edit'
  end



end
