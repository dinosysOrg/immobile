module Responses
  require 'json'
  extend ActiveSupport::Concern

  def response_success
    Response.new(Constant::MESSAGE_SUCCESS, Constant::STATUS_CODE_SUCCESS)
  end

  def response_failure
    Response.new(Constant::MESSAGE_FAIL, Constant::STATUS_CODE_FAIL)
  end
end
