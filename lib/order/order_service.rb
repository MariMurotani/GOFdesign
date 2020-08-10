require "#{Rails.root}/lib/order/order_query.rb"
require "#{Rails.root}/lib/order/order_builder.rb"
require "#{Rails.root}/lib/order/order_builder_collection.rb"

# require "#{Rails.root}/lib/order/report_mail/report.rb"
# require "#{Rails.root}/lib/order/report_mail/text_report.rb"
# require "#{Rails.root}/lib/order/report_mail/html_report.rb"
#
# require "#{Rails.root}/lib/order/report_chat/formatter.rb"
# require "#{Rails.root}/lib/order/report_chat/notify.rb"
# require "#{Rails.root}/lib/order/report_chat/text_formatter.rb"

require "#{Rails.root}/lib/delivery/step.rb"
require "#{Rails.root}/lib/delivery/store_stock.rb"
require "#{Rails.root}/lib/delivery/ec_stock.rb"
require "#{Rails.root}/lib/delivery/factory_order.rb"
require "#{Rails.root}/lib/delivery/packaging.rb"
require "#{Rails.root}/lib/delivery/delivery.rb"

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