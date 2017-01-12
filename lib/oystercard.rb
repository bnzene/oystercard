class Oystercard
MAX_BALANCE = 90
MIN_FARE = 1
attr_reader :balance, :in_journey, :entry_station

  def initialize(balance = 0)
    @in_journey = false
    @balance = balance
    @entry_station = nil
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

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    @in_journey = true unless @entry_station == nil
  end


  private

  def sufficient_funds?
    raise "Not enough money." if balance < MIN_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end
