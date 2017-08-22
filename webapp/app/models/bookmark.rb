class Bookmark < ActiveRecord::Base

  def save_data(params)
    self.object_id = params[:object_id].to_i
    self.provider = params[:provider].to_s
    self.save
  end
end
