class Contract < ActiveRecord::Base
  has_many :contract_services

  def self.create_contract(house, userId)
    contract = Contract.new
    contract.user_id = userId
    contract.house_id = house.id
    contract.save
    return contract
  end

  def add_service(house, params, current_user)
    if (params[:services]).present?
      total = 0
      (params[:services]).each_with_index do |serviceId, index|
        contract_service = ContractService.new
        contract_service.contract_id = self.id
        contract_service.service_id = serviceId
        contract_service.save

        service = Service::find(serviceId)
        total += service.price
      end

      # TODO: optimize calc days
      totalDays = ((house.disable_at - DateTime.now.beginning_of_day).to_i / 1.day) + 1
      house.pending_money = totalDays * total
      house.save
    end
  end

end
