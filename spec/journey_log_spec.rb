require 'journey_log'

describe JourneyLog do
  let(:journey_class) { Journey }
  let(:oystercard) { instance_double("Oystercard") }
  let(:entry_station) { instance_double("Station")}
  let(:exit_station) { instance_double("Station")}
  subject(:journey_log) { described_class.new(journey_class, oystercard) }

  before(:each) do
    allow(oystercard).to receive(:deduct)
  end

  context "#initialize" do
    it 'has Journey as a parameter in journey_class' do
      expect(journey_log.journey_class).to eq Journey
    end
    it 'has an empty journeys array' do
      expect(journey_log.journeys).to be_empty
    end
    it "has an empty current journey" do
      expect(journey_log.current_journey).to be_nil
    end
  end

  context '#start' do
    it "creates a current journey" do
      journey_log.start(entry_station)
      expect(journey_log.current_journey).to be_a(Journey)
    end
    context 'with incomplete journey' do
      it 'does not err' do
        expect{journey_log.start(entry_station)}.not_to raise_error
      end
    end
  end

  context '#finish' do
    it "deducts correct fare from balance" do
      journey_log.start(entry_station)
      expect { journey_log.finish(exit_station) }.not_to raise_error
    end
    it 'increases journeys array count by one' do
      expect { journey_log.finish(exit_station) }.to change { journey_log.journeys.count }.by 1
    end
    it 'stores journey object in journeys array' do
      journey_log.finish(exit_station)
      expect(journey_log.journeys[-1]).to be_a(Journey)
    end
    it 'charges penalty with no touch in' do
      expect{ journey_log.finish(exit_station) }.not_to raise_error
    end
  end

end
