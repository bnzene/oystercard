require './lib/oystercard'
require './lib/station'
card1 = Oystercard.new
card2 = Oystercard.new
card2.top_up(20)
station = Station.new("Euston", 1)
