require_relative 'journey'

class Oystercard
MAX_BALANCE = 90
MIN_FARE = 1
attr_reader :balance, :entry_station, :journeys, :current_journey

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @current_journey = nil
    @journeys = []
  end

  def top_up(amount)
    error_message = "Exceeds max balance of #{ MAX_BALANCE }."
    raise error_message if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    sufficient_funds?
    @current_journey = Journey.new
    @current_journey.start(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @current_journey.finish(station)
    @journeys << @current_journey
    @current_journey = nil
  end


  private

  def sufficient_funds?
    raise "Not enough money." if balance < MIN_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end
