require 'oystercard'

describe Oystercard do

subject(:oystercard) { described_class.new }
subject(:oystercard2) { described_class.new 10 }
MAX_BALANCE = 90

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
    it "changes status of in_journey? to true" do
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "raises error if not enough money" do
      expect{ oystercard.touch_in }.to raise_error "Not enough money."
    end
  end

  context '#touch_out' do
    it "changes status of in_journey? to false" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it "deducts correct fare from balance" do
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by -1
    end
  end



end
