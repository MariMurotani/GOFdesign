class OrderService
  attr_reader :order, :ordered_products, :order_bill
  def initialize(account, order_id=nil)
    @account = account
    if order_id.present?
      @order = Order.find(order_id)
      @ordered_products = @order.ordered_product
      @order_bill = @order.order_bill
    else
      @order = Order.new({
         account: @account
       })
      @ordered_products = []
      @order_bill = nil
    end
  end
  def add_item(product_id, amount)
    @ordered_products << OrderedProduct.new({product_id: product_id, quantity: amount})
  end
  def set_delivery_method(method)
    @order.delivery_method = Order.delivery_methods["mail"] if method == 'mail'
    @order.delivery_method = Order.delivery_methods["express"] if method == 'express'
  end
  def estimate_time
    @ordered_products.each do | ordered_products |
      product = Product.includes(:stock).find(ordered_products.id)
      DeliveryTimeEstimate.new(product, ordered_products.amount, postal_code)
    end
  end
  def save!
    ActiveRecord::Base.transaction do
      @order.save!
      @ordered_products.each do | ordered_product |
        delivery_date_time = DeliveryTimeEstimate.new(ordered_product.product, ordered_product.quantity,@account.address.last.postal_code).delivery_date_time
        ordered_product.attributes = {
          order: @order,
          expected_delivery_date: delivery_date_time
        }
        ordered_product.save
      end
      total_price = Order::Billing::Price.new(@ordered_products.map(&:total_price).sum)
      discount_price = Order::Billing::Price.new(total_price.get_operand_price*0.13)
      shipping_fee = Order::Billing::Price.new(300)
      discounted_price = Order::Billing::Minus.new(total_price, discount_price).execute
      billing_amount = Order::Billing::Plus.new(discounted_price, shipping_fee).execute
      @order_bill = OrderBill.create({
         order: @order,
         total_price: total_price.get_operand_price,
         discount_price: discount_price.get_operand_price,
         shipping_fee: shipping_fee.get_operand_price,
         billing_amount: billing_amount.get_operand_price
      })
    end
  end
  def confirm!
    @order.order_status = Order.order_statuses["confirmed"]
    @order.save!
  end
  class DeliveryTimeEstimate
    @processes = Array.new
    def initialize(product, amount, postal_code)
      @processes = Array.new
      @product = product
      @amount = amount
      @postal_code = postal_code
    end
    def delivery_date_time
      self.define_delivery_process
      time_required = @processes.map(&:get_time_required)
      Time.zone.now.since((time_required.sum).days)
    end
    def define_delivery_process
      if (@product.stock.ec_stock_amount + @product.stock.store_stock_amount) < @amount
        @processes << Delivery::FactoryOrder.new
      elsif @product.stock.ec_stock_amount > @amount
        @processes << Delivery::EcStock.new
      else
        @processes << Delivery::StoreStock.new
      end
      @processes << Delivery::Delivery.new(@postal_code)
      @processes << Delivery::Packaging.new
    end
  end
end