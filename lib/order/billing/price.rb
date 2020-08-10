module Order::Billing
  module Status
    YEN = 1
    DOLL = 2
    EURO = 3
  end
  class Price < Operand
    def initialize(price)
      @operand_price = price
      @bill_type = Order::Billing::Status::YEN
    end
    def get_operand_price
      @operand_price if @bill_type == Status::YEN
    end
  end
end