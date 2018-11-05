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
    end
  end
end
