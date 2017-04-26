class EditorController < ApplicationController
  before_action :authenticate_user!

  def new
    @pageType = 'new'
    render :'new', status: :ok, :layout => 'editor'
  end

  def list
    @pageType = 'list'
    render :'list', status: :ok, :layout => 'editor'
  end

end
