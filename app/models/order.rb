class Order < ApplicationRecord
  has_many :ordered_product, dependent: :destroy
  belongs_to :account
end