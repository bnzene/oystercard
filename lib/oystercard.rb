require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance, :journey_log

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new(Journey, self)
  end

  def top_up(amount)
    error_message = "Exceeds max balance of #{ MAX_BALANCE }."
    raise error_message if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    sufficient_funds?
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
  end

  private

  def sufficient_funds?
    raise "Not enough money." if balance < Journey::MIN_FARE
  end

end
