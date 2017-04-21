class HomeController < ApplicationController

  def index

  end

  def search

  end

  def detail
    if params[:id].to_i == 1
      @coverUrl = "/assets/khanhcasa.jpg"
      @matterUrl = "https://my.matterport.com/show/?m=f8Er8NwRrDs"
    else
      @coverUrl = "/assets/canho1.jpg"
      @matterUrl = "https://my.matterport.com/show/?m=b7TQHKcT9oY"
    end
  end

  def contact

  end

end
