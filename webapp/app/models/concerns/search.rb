module Search
  extend ActiveSupport::Concern

  included do
    scope :by_wildcard_with_email, -> (wildcard_search) { where("email LIKE ?", wildcard_search) }
    scope :by_wildcard_with_address, -> (wildcard_search) { where("address LIKE ?", wildcard_search) }
    scope :by_wildcard_with_name, -> (wildcard_search) { where("name LIKE ?", wildcard_search) }
    scope :by_wildcard_with_phone, -> (wildcard_search) { where("phone LIKE ?", wildcard_search) }

    scope :by_wildcard_with_name_or_email, -> (wildcard_search) {
      where("name LIKE ? OR email LIKE ?", wildcard_search, wildcard_search) }
    scope :by_wildcard_with_name_or_address, -> (wildcard_search) {
      where("name LIKE ? OR address LIKE ?", wildcard_search, wildcard_search) }
    scope :by_wildcard_with_name_or_phone, -> (wildcard_search) {
      where("name LIKE ? OR phone LIKE ?", wildcard_search, wildcard_search) }
    scope :by_wildcard_with_email_or_address, -> (wildcard_search) {
      where("email LIKE ? OR address LIKE ?", wildcard_search, wildcard_search) }
    scope :by_wildcard_with_email_or_phone, -> (wildcard_search) {
      where("email LIKE ? OR phone LIKE ?", wildcard_search, wildcard_search) }
    scope :by_wildcard_with_address_or_phone, -> (wildcard_search) {
      where("address LIKE ? OR phone LIKE ?", wildcard_search, wildcard_search) }

    scope :by_wildcard_with_name_or_email_or_address, -> (wildcard_search) {
      where("name LIKE ? OR email LIKE ? or address LIKE ?", wildcard_search, wildcard_search, wildcard_search) }
    scope :by_wildcard_with_name_or_email_or_phone, -> (wildcard_search) {
      where("name LIKE ? OR email LIKE ? or phone LIKE ?", wildcard_search, wildcard_search, wildcard_search) }
    scope :by_wildcard_with_email_or_phone_or_address, -> (wildcard_search) {
      where("email LIKE ? OR phone LIKE ? or address LIKE ?", wildcard_search, wildcard_search, wildcard_search) }
    scope :by_wildcard_with_name_or_phone_or_address, -> (wildcard_search) {
      where("name LIKE ? OR phone LIKE ? or address LIKE ?", wildcard_search, wildcard_search, wildcard_search) }


    scope :by_wildcard_with_name_or_email_or_address_or_phone,
      -> (wildcard_search) { where("name LIKE ? OR email LIKE ? OR address LIKE ? or phone LIKE ?", wildcard_search, wildcard_search, wildcard_search, wildcard_search) }
  end
end
