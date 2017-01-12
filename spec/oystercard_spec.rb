require 'oystercard'

describe Oystercard do
  context "Freshly initialized card" do
    it "Tests that a new card has a balance of 0 by default" do
      subject = Oystercard.new
      expect(subject.balance).to eq(0)
    end
  end
end
