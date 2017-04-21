class EditorController < ApplicationController

  def new
    @pageType = 'new'
    render :'new', status: :ok, :layout => 'editor'
  end

  def list
    @pageType = 'list'
    render :'list', status: :ok, :layout => 'editor'
  end

end
