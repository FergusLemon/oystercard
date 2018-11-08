require 'journey'

describe Journey do
  let(:entry_station) { double :station }
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
  end
end
