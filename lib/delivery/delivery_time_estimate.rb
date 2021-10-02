class DeliveryTimeEstimate
  attr_reader :processes

  @processes = []
  def initialize(product, amount, postal_code)
    @processes = []
    @product = product
    @amount = amount
    @postal_code = postal_code
  end

  def estimate_delivery_date_time
    self.define_delivery_process
    time_required = @processes.map(&:time_required)
    Time.zone.now.since((time_required.sum).days)
  end

  def define_delivery_process
    raise 'Undefined product error' if @product.nil?

    if (@product.stock.ec_stock_amount + @product.stock.store_stock_amount) < @amount
      @processes << Delivery::FactoryOrder.new
    elsif @amount < @product.stock.ec_stock_amount
      @processes << Delivery::EcStock.new
    else
      @processes << Delivery::StoreStock.new
    end
    @processes << Delivery::Delivery.new(@postal_code)
    @processes << Delivery::Packaging.new
  end
end
