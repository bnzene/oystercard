require 'journey'

describe Journey do

subject(:journey) { described_class.new }
let(:entry_station) { instance_double("Station") }
let(:exit_station) { instance_double("Station") }


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

    it "records entry_station" do
      pending "refactor"
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end

    it "changes status of in_journey? to true" do
      pending "refactor"
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
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

end
