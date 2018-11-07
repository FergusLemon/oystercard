require 'oystercard'

describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:oystercard_10) { described_class.new(10) }

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
    describe '#in_use' do
      it 'is not in use by default' do
        expect(oystercard.in_use).to eq(false)
      end
    end
    describe '#entry_station' do
      it 'is nil by default' do
        expect(oystercard.entry_station).to eq(nil)
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
    context 'when the balance is above the minimum fare' do
      before(:each) do
        minimum_fare = described_class::MIN_FARE
        oystercard.top_up(minimum_fare)
      end
      it 'updates the oystercard to being in use' do
        expect { oystercard.touch_in }.to change { oystercard.in_use }.to(true)
      end
      it 'raises an error when the card is already in use' do
        oystercard.touch_in
        expect { oystercard.touch_in }.to raise_error \
          "You must touch out before starting a new journey."
      end
    end
    context 'when the balance is below the minimum fare' do
      it 'raises an error when the balance on the card is insufficient' do
        expect { oystercard.touch_in }.to raise_error \
          "Your balance (£#{oystercard.balance}) is insufficient, you need a \
balance of £#{described_class::MIN_FARE} to travel."
      end
    end
  end

  describe '#touch_out' do
    before(:each) do
      oystercard.top_up(described_class::MIN_FARE)
      oystercard.touch_in
    end
    it 'updates the oystercard to not being in use' do
      expect { oystercard.touch_out }.to change { oystercard.in_use }.to(false)
    end
    it 'reduces the balance on the card by the minimum fare' do
      minimum_fare = described_class::MIN_FARE
      expect { oystercard.touch_out }.to change \
        { oystercard.balance }.by(-minimum_fare)
    end
    it 'raises an error if the oystercard is not in use' do
      oystercard.touch_out
      expect { oystercard.touch_out }.to raise_error \
        "Your card appears not to have been touched in, please contact a \
member of station staff."
    end
  end
end
#      it 'raises an error if the deduction takes the balance below zero' do
#        large_deduction = rand(91..100)
#        expect { oystercard.deduct(large_deduction) }.to raise_error \
#        "Your balance is #{oystercard.balance}, you do not have enough for \
# this transaction."
#      end
