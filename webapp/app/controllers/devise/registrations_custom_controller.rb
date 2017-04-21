class Devise::RegistrationsCustomController < Devise::RegistrationsController
  before_filter :check_permissions, :only => [:new, :create, :cancel]
  skip_before_filter :require_no_authentication

  def check_permissions
    authorize! :create, resource
  end

  def create
    @user = User.new(sign_up_params)
    @user.user_ts = Time.current
    @user.token = Devise.friendly_token[0, 20]
    @user.name = @user.firstname+' '+@user.lastname
    if @user.save
      flash[:notice] = "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."
      redirect_to root_url
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def sign_up_params
    allow = [:email, :password, :password_confirmation, :firstname,:lastname]
    params.require(resource_name).permit(allow)
  end
end
