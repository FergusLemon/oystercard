require 'oystercard'

describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:oystercard_10) { described_class.new(10) }
  let(:another_oystercard) { described_class.new }
  let(:entry_station) { double('entry station', entry_station: 'Euston', zone: 2) }
  let(:exit_station) { double('exit station', exit_station: 'Angel', zone: 2) }
  let(:journey) { double('journey', entry_station: entry_station, exit_station: exit_station) }
  PENALTY = 6

  context 'on initialization' do
    describe '#balance' do
      it 'displays a balance' do
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
      it 'allows a user to add money' do
        expect(oystercard).to respond_to(:top_up).with(1).argument
      end
      it 'increases the balance on the card by the amount topped up' do
        random_top_up = rand(1..90)
        oystercard.top_up(random_top_up)
        expect(oystercard.balance).to eq(random_top_up)
      end
      it 'raises an error if the top up would exceed the max balance' do
        max_balance = described_class::MAX_BALANCE
        oystercard.top_up(max_balance)
        random_top_up = rand(1..90)
        expect { oystercard.top_up(random_top_up) }.to raise_error \
          "Sorry the maximum balance is #{described_class::MAX_BALANCE}, \
please try topping up a lower amount."
      end
    end
  end

  describe '#touch_in' do
    context 'when the balance is below the minimum fare' do
      it 'raises an error when the balance on the card is insufficient' do
        expect { oystercard.touch_in(entry_station) }.to raise_error \
          "Your balance (£#{oystercard.balance}) is insufficient, you need a \
balance of £#{described_class::MIN_FARE} to travel."
      end
    end
    context 'when the touch in is invalid' do
      it 'deducts the penalty fare' do
        oystercard.top_up(described_class::MIN_FARE)
        oystercard.touch_in(entry_station)
        expect { oystercard.touch_in(entry_station) }.to change \
          { oystercard.balance }.by(-PENALTY)
      end
    end
    context 'when the touch in is valid' do
      it 'does not deduct anything' do
        oystercard.top_up(described_class::MIN_FARE)
        allow(journey).to receive(:complete?).and_return(true)
        oystercard.touch_in(entry_station)
        expect(oystercard.balance).to eq(described_class::MIN_FARE)
      end
    end
  end

  describe '#touch_out' do
    before(:each) do
      oystercard.top_up(described_class::MAX_BALANCE)
      oystercard.touch_in(entry_station)
    end
    it 'reduces the balance on the card by the minimum fare' do
      minimum_fare = described_class::MIN_FARE
      expect { oystercard.touch_out(exit_station) }.to change \
        { oystercard.balance }.by(-minimum_fare)
    end
    context 'when the touch out is invalid' do
      it 'deducts the penalty fare' do
        oystercard.touch_out(exit_station)
        expect { oystercard.touch_out(exit_station) }.to change \
          { oystercard.balance }.by(-PENALTY)
      end
      it 'raises an error if the balance is negative' do
        minimum_fare = described_class::MIN_FARE
        another_oystercard.touch_out(exit_station)
        expect { another_oystercard.touch_out(exit_station) }.to raise_error \
          { "You have a negative balance of #{another_oystercard.balance},\
            please top up at least #{-another_oystercard.balance + minimum_fare}\
            before making your journey." }
      end
    end
  end
end
