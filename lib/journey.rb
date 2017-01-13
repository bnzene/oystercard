class Journey

  MIN_FARE = 1
  PENALTY = 6

  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def complete?
    @entry_station && @exit_station
  end

  def fare
    complete? ? MIN_FARE : PENALTY
  end

end
