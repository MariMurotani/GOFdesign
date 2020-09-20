class ReportChat::Notify
  def initialize(order_builder, formatter)
    @order_builder = order_builder
    @formatter = formatter
  end
  def output_report
    @formatter.output_report(@order_builder)
  end
  def notify_to_chat_room
    # TODO: SEND INROMATION
  end
end