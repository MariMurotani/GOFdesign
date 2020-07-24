module Delivery
  class Packaging < Step
    def initialize
      @name = "梱包"
    end
    def get_time_required
      1
    end
  end
end