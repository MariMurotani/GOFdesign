class Product < ApplicationRecord
  include ActiveModel::Serialization
  has_many :ordered_products
  has_many :order, through: :ordered_products
  has_one :stock
  scope :with_stock, -> { joins(:stock) }
end
