class Product < ApplicationRecord
  has_many :order
  has_one :stock
end
