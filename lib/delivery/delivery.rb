module Delivery
  class Delivery < Step
    def initialize(postal_code)
      @postal_code = postal_code
      @name = "配送時間"
    end

    def time_required
      if @postal_code == "1000000"
        Areas::Kanto.new.time_required
      elsif @postal_code == "9000000"
        Areas::Okinawa.new.time_required
      else
        3
      end
    end
  end
end
