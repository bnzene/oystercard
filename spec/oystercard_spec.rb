require 'oystercard'

describe Oystercard do

subject(:oystercard) { described_class.new }
subject(:oystercard2) { described_class.new 10 }
MAX_BALANCE = 90
MIN_FARE = 1
let(:entry_station) { double :station1 }
let(:exit_station) { double :station2 }


  context "Freshly initialized card" do
    it "Tests that a new card has a balance of 0 by default" do
      expect(oystercard.balance).to eq(0)
    end
  end

  context "#top_up" do
    it "tops up the oystercard" do
      expect{subject.top_up(10)}.to change { subject.balance }.by 10
    end

    it "raises error when top-up would go over max balance" do
      message = "Exceeds max balance of #{ MAX_BALANCE }."
      expect{ subject.top_up(91) }.to raise_error message
    end
  end

  context '#in_journey?' do
    it "expects card not to be in a journey by default" do
      expect(subject).not_to be_in_journey
    end
  end

  context '#touch_in' do

    it "records entry_station" do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it "changes status of in_journey? to true" do
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
    it "raises error if not enough money" do
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Not enough money."
    end
  end

  context '#touch_out' do
    before do
      subject.touch_in(entry_station)
    end

    it "changes status of in_journey? to false" do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it "deducts correct fare from balance" do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -MIN_FARE
    end

    it "sets the entry_station to nil upon touch_out" do
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end

    it 'stores entry_station and exit_station in array of past journeys' do
      #subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include ({:entry_station=>entry_station, :exit_station=>exit_station})
    end



  end



end
