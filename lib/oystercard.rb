class Oystercard
  attr_reader :balance, :in_use
  MAX_BALANCE = 90
  MIN_FARE = 1

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
    raise "Your balance (£#{self.balance}) is insufficient, you need a balance of £#{MIN_FARE} to travel." if low_balance?
    start_journey
  end

  def touch_out
    finish_journey
  end

  private

  def max_balance_hit?(amount)
    balance + amount > MAX_BALANCE
  end

  def insufficient_funds?(amount)
    balance - amount < 0
  end

  def low_balance?
    balance < MIN_FARE
  end

  def start_journey
    @in_use = true
  end

  def finish_journey
    @in_use = false
  end

  def in_journey?
    in_use
  end
end
