require 'oystercard'

describe Oystercard do

subject(:oystercard) { described_class.new }
MAX_BALANCE = 90

  context "Freshly initialized card" do
    it "Tests that a new card has a balance of 0 by default" do
      expect(subject.balance).to eq(0)
    end
  end

  context "#top_up" do
    it "tops up the oystercard" do
      expect(subject.top_up(10)).to eq 10
    end

    it "raises error when top-up would go over max balance" do
      message = "Exceeds max balance of #{ MAX_BALANCE }."
      expect{ subject.top_up(91) }.to raise_error message
    end
  end

  context '#deduct' do
    it "deducts money from the balance" do
      subject.top_up(5)
      expect{ subject.deduct 5 }.to change { subject.balance }.by -5
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
  end

  context '#touch_out' do
    it "changes status of in_journey? to false" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end



end
