class OrderBuilderCollection
  include Enumerable
  def initialize(order)
    @orders = order
  end
  def each
    @orders.each do | order |
      yield OrderBuilder.new(order)
    end
  end
end