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
      expect{subject.top_up(91)}.to raise_error message
    end
  end

end
