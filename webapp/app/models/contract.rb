class Contract < ActiveRecord::Base

  def self.create_contract(house, userId)
    contract = Contract.new
    contract.user_id = userId
    contract.house_id = house.id
    contract.save
  end
end
