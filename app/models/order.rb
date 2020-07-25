class Order < ApplicationRecord
  has_many :ordered_product, dependent: :destroy
  belongs_to :account
  enum delivery_method: { express: 0, mail: 1 }
  enum payment_method: { cash: 0, credit_card: 1 }
end