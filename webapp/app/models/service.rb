class Service < ActiveRecord::Base
  include Search

  scope :by_desc_order, -> (page_param, per_page) { order(created_at: :desc).page(page_param).per(per_page) }

  def self.search(search_param, page_param, per_page)
    wildcard_search = "%#{search_param}%"
    Service
        .by_wildcard_with_name(wildcard_search).order(created_at: :desc).page(page_param).per(per_page)
  end

  def save_data(params)
    self.price = params[:price].to_i
    self.currency = params[:currency].to_s
    self.description = params[:description].to_s
    self.save
  end

end
