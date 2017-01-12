require './lib/station'

describe Station do

  subject(:station) { described_class.new "Euston", 1 }

  context '#name' do
    it 'has a name' do
      expect(subject.name).to eq "Euston"
    end
  end

  context '#zone' do
    it 'belongs to a zone' do
      expect(subject.zone).to eq 1
    end
  end

end
