require 'journey_log'

describe JourneyLog do
  let(:journey_log) { described_class.new }

  context 'on initialization' do
    it 'contains an empty array to store journeys in' do
      expect(journey_log.journeys).to eq([])
    end
  end
end
