class House < ActiveRecord::Base
  has_many :house_conveniences
  has_many :house_furnitures
  has_many :photos

  def save_house(house, params)

    self.project_id = params[:project_id]
    self.estate_id = params[:estate_id]
    self.name = params[:name]
    self.address = params[:address]
    self.number_bedroom = params[:number_bedroom].to_i
    self.number_bathroom = params[:number_bathroom].to_i
    self.number_bathroom = params[:number_bathroom].to_i
    self.size = params[:size].to_i
    self.price = params[:price].to_i
    self.currency = params[:currency]
    self.matterport_url = params[:matterport_url]
    self.description = params[:description]
    self.host_type = params[:host_type]
    self.matterport_url = params[:matterport_url]

    self.status = Constant::HOUSE_STATUS_PENDING
    if params[:for_rent] == 'true'
      self.for_rent = true
    else
      self.for_rent = false
    end
    self.save

    if params[:furnitures].present?
      params[:furnitures].each_with_index do |furnitureId, idx|
        houseFurniture = HouseFurniture.new
        houseFurniture.house_id = house.id
        houseFurniture.furniture_id = furnitureId
        houseFurniture.save
      end
    end

    if params[:conveniences].present?
      params[:conveniences].each_with_index do |convenienceId, idx|
        houseConvenience = HouseConvenience.new
        houseConvenience.house_id = house.id
        houseConvenience.convenience_id = convenienceId
        houseConvenience.save
      end
    end

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

    # wish list house
    # wish list agent
    # budget
  end

end
