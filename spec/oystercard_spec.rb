require 'oystercard'

describe Oystercard do
  let(:oystercard) { described_class.new }

  context "on initialization" do
    context "#balance" do
      it 'has a balance' do
        expect(oystercard).to respond_to(:balance)
      end
      it 'has a default balance of zero' do
        expect(oystercard.balance).to equal(0)
      end
    end
  end
end
