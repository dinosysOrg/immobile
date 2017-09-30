class HomeController < ApplicationController

  def index
    @estates = Estate.all


  end

  def agents
    agent_roles = RoleUser.where(role_id: 2).pluck('user_id')
    @agents = User.where('id in (?)', agent_roles)
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
