class OrderBuilder
  def initialize(order)
    @order = order
    @mask = false
    @visible_account = false
    @visible_address = false
    @visible_order_details = false
  end

  def set_mask
    @mask = true
    self
  end

  def visible_account
    @visible_account = true
    self
  end

  def visible_address
    @visible_address = true
    self
  end

  def visible_order_details
    @visible_order_details = true
    self
  end

  def format_account
    if @mask
      {
        name: "#{@order.account.name&.slice(1, 3)}***",
        email: "#{@order.account.email&.slice(1, 3)}***",
      }
    else
      {
        name: @order.account.name,
        email: @order.account.email,
      }
    end
  end

  def format_order
    result = {
      delivery_method: @order.delivery_method,
      payment_method: @order.payment_method,
      products: []
    }
    result[:products].tap do |result_products|
      @order.ordered_products.each do |product|
        result_products << {
          name: product.product.name,
          quantity: product.quantity,
          expected_delivery_date: product[:expected_delivery_date]&.strftime('%Y/%m/%d')
        }
      end if visible_order_details
    end
    result
  end

  def format_address
    address = @order.account.addresses.first
    if @mask
      {
        postal_code: address.postal_code,
        address: "#{address.country} #{address.state} ********",
      }
    else
      {
        postal_code: address.postal_code,
        address: "#{address.country} #{address.state} #{address.city} #{address.street}",
      }
    end
  end

  def to_json(*_args)
    {}.tap do |result|
      result[:account] = format_account if @visible_account
      result[:address] = format_address if @visible_address
      result[:order] = format_order
    end
  end
end
