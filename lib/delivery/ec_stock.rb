module Delivery
  class EcStock < Step
    def initialize
      @name = "EC在庫取得時間"
    end

    def time_required
      1
    end
  end
end
