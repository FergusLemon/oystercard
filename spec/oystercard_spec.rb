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
        expect { oystercard.top_up(random_top_up) }.to raise_error(RuntimeError, "Sorry the maximum balance is #{described_class::MAX_BALANCE}, please try topping up a lower amount.")
      end
    end
  end

  describe '#deduct' do
    it 'allows a user to deduct money' do
      expect(oystercard).to respond_to(:deduct).with(1).argument
    end
    context 'when there is money available' do
      before(:each) do
        large_top_up = rand(50..90)
        oystercard.top_up(large_top_up)
      end
      it 'reduces the balance' do
        small_deduction = rand(1..20)
        expect { oystercard.deduct(small_deduction) }.to change { oystercard.balance }.by(-small_deduction)
      end
      it 'raises an error if the deduction would take the balance below zero' do
        large_deduction = rand(91..100)
        expect { oystercard.deduct(large_deduction) }.to raise_error(RuntimeError, "Your balance is #{oystercard.balance}, you do not have enough for this transaction.")
      end
    end
  end

  describe '#touch_in' do
    it 'updates the oystercard to being in use' do
      expect { oystercard.touch_in }.to change { oystercard.in_use }.to(true)
    end
  end
end
