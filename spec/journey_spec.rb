require 'journey'

describe Journey do
  let(:entry_station) { double('entry station', entry_station: 'Euston', zone: 2) }
  let(:exit_station) { double('exit station', exit_station: 'Angel', zone: 2) }
  let(:another_exit_station)\
     { double('another_exit station', exit_station: 'Tooting', zone: 4) }
  let(:journey) { described_class.new(entry_station) }
  let(:other_journey) { described_class.new }

  context 'on initialization' do
    describe '#entry_station' do
      context 'when on a valid journey' do
        it 'records the station given' do
          expect(journey.entry_station).to eq(entry_station)
        end
      end
      context 'when on an invalid journey' do
        it 'records a nil value for the entry station' do
          expect(other_journey.entry_station).to eq(nil)
        end
      end
    end
    describe '#exit_station' do
      it 'records a nil value by default' do
        expect(journey.exit_station).to eq(nil)
      end
    end
  end

  describe 'MIN_FARE' do
    it 'has a minimum fare' do
      expect(journey).to have_constant(:MIN_FARE)
    end
  end

  describe 'PENALTY_FARE' do
    it 'has a penalty fare' do
      expect(journey).to have_constant(:PENALTY_FARE)
    end
  end

  describe '#calculate_fare' do
    context 'when it is a valid journey' do
      it 'returns the minimun fare' do
        minimum_fare = described_class::MIN_FARE
        journey.exit(exit_station)
        expect(journey.calculate_fare).to eq(minimum_fare)
      end
      it 'calculates the zone charge' do
        minimum_fare = described_class::MIN_FARE
        zone_fare = 2
        journey.exit(another_exit_station)
        expect(journey.calculate_fare).to eq(minimum_fare + zone_fare)
      end
    end
  end

  describe '#exit' do
    it 'records the exit station' do
      journey.exit(exit_station)
      expect(journey.exit_station).to eq(exit_station)
    end
  end

  describe '#complete?' do
    context 'when there is and entry and an exit station' do
      it 'knows the journey is complete' do
        journey.exit(exit_station)
        expect(journey).to be_complete
      end
    end
    context 'when there is only an entry_station' do
      it 'knows the journey is incomplete' do
        expect(journey).not_to be_complete
      end
    end
  end
end
