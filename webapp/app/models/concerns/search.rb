module Search
  extend ActiveSupport::Concern

  included do
    scope :by_wildcard, -> (wildcard_search) { where("name LIKE ? OR address LIKE ?", wildcard_search, wildcard_search) }
  end
end
