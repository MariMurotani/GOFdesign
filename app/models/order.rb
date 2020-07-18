class Order < ApplicationRecord
  belongs_to :product
  has_many :ordered_product, dependent :destroy
  has_one :account
end