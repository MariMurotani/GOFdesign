module Delivery
  class Areas::Kanto < Step
    def initialize
      @name = "関東への配送時間"
    end

    def time_required
      2
    end
  end
end
