class Oystercard
  attr_reader :balance, :in_use
  MAX_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @in_use = false
  end

  def top_up(amount)
    raise "Sorry the maximum balance is #{MAX_BALANCE}, please try topping up a lower amount." if max_balance_hit?(amount)
    @balance += amount
  end

  def deduct(amount)
    raise "Your balance is #{self.balance}, you do not have enough for this transaction." if insufficient_funds?(amount)
    @balance -= amount
  end

  def touch_in
    raise "You must touch out before starting a new journey." if in_journey?
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  private

  def max_balance_hit?(amount)
    balance + amount > MAX_BALANCE
  end

  def insufficient_funds?(amount)
    balance - amount < 0
  end

  def in_journey?
    in_use
  end
end
