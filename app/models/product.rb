class Product < ApplicationRecord
  include ActiveModel::Serialization
  has_many :ordered_products
  has_many :order, through: :ordered_products
  has_one :stock
  scope :with_stock, -> { joins(:stock) }
  def to_json
    result = self.attributes
    result["ec_stock_amount"] = self&.stock&.ec_stock_amount
    result["store_stock_amount"] = self&.stock&.store_stock_amount
    result
  end
end
