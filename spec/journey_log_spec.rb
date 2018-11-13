require 'journey_log'

describe JourneyLog do
  let(:journey_log) { described_class.new(journey_klass) }
  let(:journey_klass) { double("journey klass") }

  context 'on initialization' do
    it 'contains an empty array to store journeys in' do
      expect(journey_log.journeys).to eq([])
    end
    it 'contains an instance of journey_klass when passed as an argument' do
      expect(journey_log.journey_klass).to eq(journey_klass)
    end
  end
end
