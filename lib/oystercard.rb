class Oystercard
  attr_reader :balance, :journey_history
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @journey_history = []
  end

  def top_up(amount)
    raise "Sorry the maximum balance is #{MAX_BALANCE}, please try topping up \
a lower amount." if max_balance_hit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Your balance (£#{balance}) is insufficient, you need a balance \
of £#{MIN_FARE} to travel." if low_balance?
    journey = Journey.new(station)
    journey_history << journey
  end

  def touch_out(station)
    deduct(MIN_FARE)
    journey_history.last.record_exit(station)
  end

  private

  def deduct(amount)
    raise "Your balance is #{balance}, you do not have enough for this \
transaction." if insufficient_funds?(amount)
    @balance -= amount
  end

  def max_balance_hit?(amount)
    balance + amount > MAX_BALANCE
  end

  def insufficient_funds?(amount)
    balance - amount < 0
  end

  def low_balance?
    balance < MIN_FARE
  end
end
