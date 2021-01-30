module Delivery
  class FactoryOrder < Step
    def initialize
      @name = "工場注文"
    end

    def get_time_required
      1
    end
  end
end
