class Order < ApplicationRecord
  has_many :ordered_product, dependent: :destroy
  belongs_to :account
  enum delivery_method: { express: 0, mail: 1 }
  enum payment_method: { cash: 0, credit_card: 1 }
  enum order_status: { created: 0, confirmed: 1, payment_process: 2, shopping_process: 3, refund: 4 }
  after_initialize :set_default, if: :new_record?
  def set_default
    self.order_status ||= Order.order_statuses["created"]
  end
end