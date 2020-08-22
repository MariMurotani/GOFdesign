class Product < ApplicationRecord
  has_many :order
  has_one :stock
  scope :with_stock, -> { joins(:stock) }
  def to_json
    result = self
    result[:ec_stock_amount] = self.stock.ec_stock_amount
    result[:store_stock_amount] = self.stock.store_stock_amount
  end
end
