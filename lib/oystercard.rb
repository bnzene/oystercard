class Oystercard
MAX_BALANCE = 90
MIN_FARE = 1
attr_reader :balance, :in_journey, :entry_station, :journeys

  def initialize(balance = 0)
    @in_journey = false
    @balance = balance
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    error_message = "Exceeds max balance of #{ MAX_BALANCE }."
    raise error_message if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    sufficient_funds?
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journeys << { entry_station: entry_station, exit_station: station }
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end


  private

  def sufficient_funds?
    raise "Not enough money." if balance < MIN_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end
