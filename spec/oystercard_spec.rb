require 'oystercard'

describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:oystercard_10) { described_class.new(10) }

  context 'on initialization' do
    describe '#balance' do
      it 'has a balance' do
        expect(oystercard).to respond_to(:balance)
      end
      it 'has a default balance of zero' do
        expect(oystercard.balance).to eq(0)
      end
      it 'can be chosen by the user when the card is purchased' do
        expect(oystercard_10.balance).to eq(10)
      end
      it 'has a maximum balance of 90' do
        expect(described_class::MAX_BALANCE).to eq(90)
      end
    end
  end

  context 'when topping up' do
    describe '#top_up' do
      it 'can be topped up by a user' do
        expect(oystercard).to respond_to(:top_up).with(1).argument
      end
      it 'increases the balance on the card by the amount topped up' do
        oystercard.top_up(20)
        expect(oystercard.balance).to eq(20)
      end
      it 'raises an error if the top up would exceed the max balance' do
        oystercard.top_up(1)
        expect{ oystercard.top_up(described_class::MAX_BALANCE) }.to raise_error(RuntimeError, "Sorry the maximum balance is #{described_class::MAX_BALANCE}, please try topping up a lower amount.")
      end
    end
  end
end
