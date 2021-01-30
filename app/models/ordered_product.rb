class OrderedProduct < ApplicationRecord
  include ActiveModel::Serialization
  belongs_to :order
  belongs_to :product
  def total_price
    product.price * quantity
  end

  def attributes
    {
      product: nil
    }
  end
end
