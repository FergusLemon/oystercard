require 'journey_log'

describe JourneyLog do
  let(:journey_log) { described_class.new(journey_klass) }
  let(:journey_klass) { double("journey klass") }
  let(:entry_station) { double("entry station") }
  let(:exit_station) { double("exit station") }
  let(:journey) { double("journey", entry_station: entry_station) }
  NO_CHARGE = 0
  PENALTY = 6

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
      allow(journey).to receive(:exit).with(exit_station)
    end
    it 'adds an exit station to the current journey' do
      journey_log.end_journey(exit_station)
      last_journey = journey_log.journeys.last
      expect(last_journey).to eq(journey)
    end
  end

  describe '#unpaid_charges' do
    it 'returns the penalty charge when the prior journey was incomplete' do
      allow(journey).to receive(:complete?).and_return(false)
      allow(journey).to receive(:exit).and_return(journey)
      allow(journey).to receive(:calculate_fare).and_return(PENALTY)
      expect(journey_log.unpaid_charges).to eq(PENALTY)
    end
    it 'returns no charge when the prior journey was complete' do
      allow(journey).to receive(:complete?).and_return(true)
      expect(journey_log.unpaid_charges).to eq(NO_CHARGE)
    end
  end
end
