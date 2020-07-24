# require "#{Rails.root}/lib/delivery/step.rb"
# require "#{Rails.root}/lib/delivery/delivery.rb"
# require "#{Rails.root}/lib/delivery/ec_stock.rb"
# require "#{Rails.root}/lib/delivery/factory_order.rb"
# require "#{Rails.root}/lib/delivery/packaging.rb"
# require "#{Rails.root}/lib/delivery/store_stock.rb"
# Dir[File.dirname(__FILE__) + '/delivery/areas/*.rb'].each {|file| require file }

class OrderService
  attr_reader :processes
  def initialize(product_id, amount, postal_code)
    @processes = Array.new
    @product = Product.includes(:stock).find(product_id)
    @amount = amount
    @postal_code = postal_code
  end
  def delivery_date_time
    self.define_delivery_process
    binding.pry
    time_required = @processes.map(&:get_time_required)
  end
  def define_delivery_process
    if (@product.stock.ec_stock_amount + @product.stock.store_stock_amount) < @amount
      @processes << FactoryOrder
    elsif @product.stock.ec_stock_amount > @amount
      @processes << ECStock.new
    else
      @processes << StoreStock.new
    end
    @processes << Delivery.new(@postal_code)
    @processes << Packaging.new
  end
end