require 'oystercard'
require 'journey'

describe Oystercard do

subject(:oystercard) { described_class.new }
subject(:journey) { instance_double("Journey") }
let(:entry_station) { instance_double("Station") }
let(:exit_station) { instance_double("Station") }
let(:journey_log) { instance_double("JourneyLog") }


  context "Freshly initialized card" do
    it "has a balance of 0 by default" do
      expect(oystercard.balance).to eq(0)
    end

    it 'has an empty journey log' do
      allow(journey_log).to receive(:journeys) { [] }
      expect(oystercard.journey_log.journeys).to be_empty
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

  context '#deduct' do
    it 'deducts a given amount' do
      expect{ oystercard.deduct(15) }.to change{oystercard.balance}.by -15
    end
  end

  context "#touch_in" do
    context "with no funds" do
      it "raises error" do
        expect{ oystercard.touch_in(entry_station) }.to raise_error "Not enough money."
      end
    end
    # context 'failed to touch out on previous journey' do
    #   oystercard.top_up(Journey::MIN_FARE + 10)
    #   oystercard.touch_in(entry_station)
    #   expect { oystercard.touch_in(entry_station) }.to change{ oystercard.balance } by -Journey::PENALTY
    # end
  end

  context '#touch_out' do
    it 'calls #start on journey_log' do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      allow(journey_log).to receive(:finish)
      expect { oystercard.touch_out(exit_station) }.not_to raise_error
    end
  end

end
