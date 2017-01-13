require_relative 'journey'
require_relative 'station'

class Oystercard
  MAX_BALANCE = 90
  attr_reader :balance, :journeys, :current_journey

  def initialize(balance = 0)
    @balance = balance
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
    incomplete_journey_penalty if @current_journey
    create_current_journey
    @current_journey.start(station)
  end

  def touch_out(station)
    @current_journey ? complete_current_journey(station) : no_current_journey_penalty(station)
  end

  private

  def sufficient_funds?
    raise "Not enough money." if balance < Journey::MIN_FARE
  end

  def incomplete_journey_penalty
    @current_journey.finish(nil)
    deduct(@current_journey.fare)
    empty_current_journey
  end

  def no_current_journey_penalty(station)
    create_current_journey
    complete_current_journey(station)
  end

  def deduct(amount)
    @balance -= amount
  end

  def create_current_journey
    @current_journey = Journey.new
  end

  def add_journey
    @journeys << @current_journey
    empty_current_journey
  end

  def empty_current_journey
    @current_journey = nil
  end

  def complete_current_journey(station)
    @current_journey.finish(station)
    deduct(@current_journey.fare)
    add_journey
  end

end
