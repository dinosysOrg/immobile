class Project < ActiveRecord::Base
  include Search

  has_many :photos
  scope :by_order, -> (sort_by, page_param, per_page) { where(:is_available => true).order(sort_by).page(page_param).per(per_page) }

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

  def self.search(sort_by, search_param, page_param, per_page)
    wildcard_search = "%#{search_param}%"
    Project
      .by_wildcard_with_name_or_address(wildcard_search)
      .where(:is_available => true).order(sort_by).page(page_param).per(per_page)
  end
end
