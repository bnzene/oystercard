require 'station'

describe Station do

  subject(:station) { described_class.new "Euston", 1 }

  context '#name' do
    it 'has a name' do
      expect(station.name).to eq "Euston"
    end
  end

  context '#zone' do
    it 'has a zone' do
      expect(station.zone).to eq 1
    end
  end

end
