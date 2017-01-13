require 'journey'
require 'oystercard'

describe Journey do

subject(:journey) { described_class.new }
let(:entry_station) { instance_double("Station") }
let(:exit_station) { instance_double("Station") }
let(:oystercard) { instance_double("Oystercard") }


  context "#initialize" do
    it "with empty entry station" do
      expect(journey.entry_station).to eq nil
    end
    it "with empty exit station" do
      expect(journey.exit_station).to eq nil
    end
  end

  context "#start" do
    it "stores given station into entry_station" do
      journey.start(entry_station)
      expect(journey.entry_station).to eq entry_station
    end
  end

  context "#finish" do
    it "stores given station into exit_station" do
      journey.finish(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  context "#complete?" do
    it "checks whether journey is complete" do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey).to be_complete
    end
  end

  context "#fare" do
    it 'charges minimum fare when journey is complete' do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.fare).to eq described_class::MIN_FARE
    end

    it 'charges penalty when journey is incomplete' do
      journey.start(entry_station)
      expect(journey.fare).to eq described_class::PENALTY
    end
  end

end
