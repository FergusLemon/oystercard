require 'journey_log'

describe JourneyLog do
  let(:journey_log) { described_class.new(journey_klass) }
  let(:journey_klass) { double("journey klass") }
  let(:entry_station) { double("entry station") }
  let(:exit_station) { double("exit station") }
  let(:journey) { double("journey", entry_station: entry_station) }

  before do |example|
    unless example.metadata[:skip_before]
      allow(journey_klass).to receive(:new).with(entry_station).\
        and_return(journey)
      journey_log.start_journey(entry_station)
    end
  end

  context 'on initialization' do
    it 'contains an empty array to store journeys in', :skip_before do
      expect(journey_log.journeys).to eq([])
    end
    it 'contains an instance of journey_klass when passed as an argument' do
      expect(journey_log.journey_klass).to eq(journey_klass)
    end
  end

  describe '#start_journey' do
    it 'stores a journey in its log' do
      expect(journey_log.journeys).to include(journey)
    end
  end

  describe '#end_journey' do
    before(:each) do
      allow(journey).to receive(:record_exit).with(exit_station)
    end
    it 'adds an exit station to the current journey' do
      journey_log.end_journey(exit_station)
      last_journey = journey_log.journeys.last
      expect(last_journey).to eq(journey)
    end
  end

  describe '#unpaid_charges' do
    before(:each) do
      allow(journey).to receive(:record_exit).with(exit_station)
    end
    it 'returns no charge when the previous journey was completed' do
      allow(journey).to receive(:complete).and_return(true)
      journey_log.end_journey(exit_station)
      expect(journey_log.unpaid_charges).to eq(0)
    end
  end
end
