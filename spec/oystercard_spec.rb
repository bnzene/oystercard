require 'oystercard'
require 'journey'

describe Oystercard do

subject(:oystercard) { described_class.new }
subject(:journey) { instance_double("Journey") }
let(:entry_station) { instance_double("Station") }
let(:exit_station) { instance_double("Station") }


  context "Freshly initialized card" do
    it "has a balance of 0 by default" do
      expect(oystercard.balance).to eq(0)
    end

    it "initializes with empty journeys array" do
      expect(oystercard.journeys).to be_empty
    end

    it "expects card not to be in a journey by default" do
      expect(oystercard.current_journey).to be_nil
    end

  end

  context "#top_up" do
    it "tops up the oystercard" do
      expect{ oystercard.top_up(10) }.to change{ oystercard.balance }.by 10
    end

    it "raises error when top-up would go over max balance" do
      message = "Exceeds max balance of #{ described_class::MAX_BALANCE }."
      expect{ oystercard.top_up(described_class::MAX_BALANCE  + 1) }.to raise_error message
    end
  end

  context "#touch_in with no funds" do
    it "raises error" do
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Not enough money."
    end
  end

  context '#touch_in' do
    before do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
    end
    it "creates a current journey" do
      expect(oystercard.current_journey).to be_a(Journey)
    end

    it 'charges penalty with incomplete journey' do
      expect{ oystercard.touch_in(entry_station) }.to change{oystercard.balance}.by -Journey::PENALTY
    end
  end

  context '#touch_out' do
    before do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
    end

    it "deducts correct fare from balance" do
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by -Journey::MIN_FARE
    end

    it 'increases journeys array count by one' do
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.journeys.count }.by 1
    end

    it 'stores journey object in journeys array' do
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys[-1]).to be_a(Journey)
    end

    it 'charges penalty with no touch in' do
      oystercard.touch_out(exit_station)
      expect{ oystercard.touch_out(exit_station) }.to change{oystercard.balance}.by -Journey::PENALTY
    end

  end


end
