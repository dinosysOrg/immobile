class Contract < ActiveRecord::Base
  has_many :contract_services

  def self.create_contract(house, userId)
    contract = Contract.new
    contract.user_id = userId
    contract.house_id = house.id
    contract.save
  end

  def add_service(params)

    if (params[:services]).present?
      (params[:services]).each_with_index do |serviceId, index|
        contract_service = ContractService.new
        contract_service.contract_id = self.id
        contract_service.service_id = serviceId
        contract_service.save
      end
    end

  end

end
