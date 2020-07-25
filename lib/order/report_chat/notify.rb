class Noitfy
  def initialize(order_builder, formatter)
    @order_builder = order_builder
    @formatter = formatter
  end
  def output_report
    @formatter.output_report(@order_builder)
  end
end