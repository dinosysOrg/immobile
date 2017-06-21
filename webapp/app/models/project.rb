class Project < ActiveRecord::Base
  has_many :photos

  def save_data(params)
    self.name = params[:name]
    self.description = params[:description]
    self.address = params[:address]
    self.size = params[:size]
    self.size_construction = params[:size_construction]
    self.time_bulding = params[:time_bulding]
    self.time_completion = params[:time_completion]
    self.number_block = params[:number_block]
    self.number_house = params[:number_house]
    self.number_shophouse = params[:number_shophouse]
    self.number_floor = params[:number_floor]
    self.investor = params[:investor]
    self.inc_management = params[:inc_management]
    self.inc_design = params[:inc_design]
    self.green_space = params[:green_space]
    self.destinition_construction = params[:destinition_construction]
    self.fee_management = params[:fee_management]
    self.fee_park_car = params[:fee_park_car]
    self.fee_park_moto = params[:fee_park_moto]
    self.progress_construction = params[:progress_construction]
    self.sale_policy = params[:sale_policy]
    self.save


    # Address to lat, lng
    lat_lng = Tool.queryLatLng(self.address)
    if lat_lng.present?
      self.latitude = lat_lng[0]
      self.longitude = lat_lng[1]
    else
      self.latitude = 0.0
      self.longitude = 0.0
    end
    self.save

    # Photo description
    if (params[:imagedest]).present?
      (params[:imagedest]).each_with_index do |imagedest, index|
        photo = self.photos[index]
        photo.description = imagedest
        photo.save
      end
    end
  end
end
