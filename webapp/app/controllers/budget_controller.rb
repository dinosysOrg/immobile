class BudgetController < ApplicationController
  include Responses
  include Sortby
  before_action :authenticate_user!
  layout 'profile'

  def index
    authorize! :show_budget, :profile

    @pageType = 'budget_profile'
  end

end
