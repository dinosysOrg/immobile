class Contract < ActiveRecord::Base

  def self.create_contract(house, userId)
    self = Contract.new
    self.user_id = userId
    self.house_id = house.id
    self.save
  end
end
