module Order::Billing
  class Minus < Operator
    def initialize(operand1, operand2)
      @operand1 = operand1
      @operand2 = operand2
    end

    def execute
      Order::Billing::Price.new(@operand1.operand_price - @operand2.operand_price)
    end
  end
end
