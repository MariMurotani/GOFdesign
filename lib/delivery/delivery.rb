class Delivery < Step
  def initialize(postal_code)
    @postal_code = postal_code
    @name = "配送時間"
  end
  def get_time_required
    if @postal_code == "1000000"
      DeliveryKanto.new.get_time_required
    elsif @postal_code == "9000000"
      DeliveryOkinawa.new.get_time_required
    else
      3
    end
  end
end