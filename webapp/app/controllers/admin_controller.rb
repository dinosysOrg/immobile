require 'openssl'

class AdminController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!, except: [:callback_budget, :webhook_github]
  skip_before_action :verify_authenticity_token, only: [:callback_budget, :webhook_github]

  # ************************** #
  # Layout
  # ************************** #



  # ************************** #
  # API
  # ************************** #

  def callback_budget
    serverKey = params[:server_key]
    responseCode = params[:vpc_TxnResponseCode].to_i

    if serverKey == Constant::ONEPAY_SERVER_KEY and responseCode == 0

      amount = params[:vpc_Amount].to_i
      merchTxnRef = params[:vpc_MerchTxnRef]
      userId = merchTxnRef.split('_')[0]

      user = User::find(userId)
      user.budget += amount/100
      user.save

      render json: response_success
    else
      render json: response_failure
    end

  end

  def webhook_github
    if params[:token].to_s == Constant::WEBHOOK_TOKEN
      # json_body = JSON.parse(request.body.read)
      json_body = JSON.parse(params[:payload])
      if json_body['ref'].present?
        branch = json_body['ref'].split('/').last
        if branch.to_s == Constant::BRANCH_MASTER
          # Create new webhook
          webhook = Webhook.new
          webhook.save
          webhook.update_script
        end
      end
      render json: response_success
    else
      render json: response_failure
    end
  end

end
