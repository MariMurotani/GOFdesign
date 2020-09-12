class Order < ApplicationRecord
  include ActiveModel::Serialization
  has_many :ordered_product, dependent: :destroy
  has_many :product, through: :ordered_product
  belongs_to :account
  has_one :order_bill
  enum delivery_method: { express: 0, mail: 1 }
  enum payment_method: { cash: 0, credit_card: 1 }
  enum order_status: { created: 0, confirmed: 1, payment_process: 2, shopping_process: 3, refund: 4 }
  after_initialize :set_default, if: :new_record?
  def set_default
    self.order_status ||= Order.order_statuses["created"]
  end
  def attributes
    {
      id: nil,
      delivery_method: nil,
      payment_method: nil,
      order_status: nil,
      created_at: nil,
      ordered_product: nil
    }
  end
end