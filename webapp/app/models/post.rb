class Post < ActiveRecord::Base

  def setData(params)

    self.name = params[:name]
    self.description = params[:description]
    self.content = params[:content]
    self.category = params[:blog_category_id]
    self.status = Constant::BLOG_STATUS_PENDING
    self.link = ''

  end

end
