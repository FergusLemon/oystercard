require 'station'

describe Station do
  let(:station) { described_class.new(:clapham_north, 2) }

  describe '#name' do
    it 'responds to name' do
      expect(station).to respond_to(:name)
    end
    it 'knows its own name' do
      expect(station.name).to eq(:clapham_north)
    end
  end
end
