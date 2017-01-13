require_relative 'journey'

class JourneyLog

  attr_reader :journey_class, :journeys, :current_journey, :oystercard

  def initialize(journey_class, oystercard)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
    @oystercard = oystercard
  end

  def start(station)
    incomplete_journey_penalty if @current_journey
    create_current_journey
    @current_journey.start(station)
  end

  def finish(station)
    @current_journey ? complete_current_journey(station) : no_current_journey_penalty(station)
  end

  private

  def create_current_journey
    @current_journey = @journey_class.new
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
    @oystercard.deduct(@current_journey.fare)
    add_journey
  end

  def incomplete_journey_penalty
    @current_journey.finish(nil)
    @oystercard.deduct(@current_journey.fare)
    add_journey
    empty_current_journey
  end

  def no_current_journey_penalty(station)
    create_current_journey
    complete_current_journey(station)
  end


end
