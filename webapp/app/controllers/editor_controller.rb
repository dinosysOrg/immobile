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

  def newProduct
    userId = current_user.id

    product = Product.new
    product.user_id = userId
    product.name = params[:name]
    product.address = params[:address]
    product.number_bedroom = params[:number_bedroom].to_i
    product.number_bathroom = params[:number_bathroom].to_i
    product.number_bathroom = params[:number_bathroom].to_i
    product.size = params[:size].to_i
    product.price = params[:price].to_i
    product.matterport_url = params[:matterport_url]
    product.description = params[:description]
    if params[:is_available] == 'true'
      product.is_available = true
    else
      product.is_available = false
    end
    product.matterport_url = params[:matterport_url]
    product.created_at = DateTime.now
    product.save

    list()
  end
end
