class Oystercard
attr_reader :balance
MAX_BALANCE = 90

  def initialize(balance=0)
    @balance = balance
  end

  def top_up(amount)
    raise "Sorry the maximum balance is #{MAX_BALANCE}, please try topping up a lower amount." if max_balance_hit?(amount)
    @balance += amount
  end

  private

  def max_balance_hit?(amount)
    balance + amount > MAX_BALANCE
  end
end
