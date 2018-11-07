require 'station'

describe Station do
  let(:station) { described_class.new(:clapham_north, 2) }

  describe '#name' do
    it 'knows its own name' do
      expect(station.name).to eq(:clapham_north)
    end
  end

  describe '#zone' do
    it 'knows its own zone' do
      expect(station.zone).to eq(2)
    end
  end
end
