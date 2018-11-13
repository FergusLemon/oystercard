require 'journey_log'

describe JourneyLog do
  let(:journey_log) { described_class.new(journey_klass) }
  let(:journey_klass) { double("journey klass") }
  let(:entry_station) { double("entry station") }
  let(:journey) { double("journey", entry_station: entry_station) }

  context 'on initialization' do
    it 'contains an empty array to store journeys in' do
      expect(journey_log.journeys).to eq([])
    end
    it 'contains an instance of journey_klass when passed as an argument' do
      expect(journey_log.journey_klass).to eq(journey_klass)
    end
  end

  describe '#start_journey' do
    before(:each) do
      allow(journey_klass).to receive(:new).with(entry_station).\
        and_return(journey)
    end
    it 'stores a journey in its log' do
      journey_log.start_journey(entry_station)
      expect(journey_log.journeys).to include(journey)
    end
  end
end
