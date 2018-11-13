class Oystercard
  attr_reader :balance, :journey_history
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @journey_history = []
    @penalty = false
  end

  def top_up(amount)
    raise "Sorry the maximum balance is #{MAX_BALANCE}, please try topping up \
a lower amount." if max_balance_hit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Your balance (£#{balance}) is insufficient, you need a balance \
of £#{MIN_FARE} to travel." if low_balance?
    record_penalty unless journey_history.empty? || touch_in_expected?
    journey = Journey.new(station)
    journey_history << journey
  end

  def touch_out(station)
    if invalid_touch_out?
      record_invalid_journey(station)
      record_penalty
    else
      journey_history.last.record_exit(station)
      deduct(journey_history.last.calculate_fare)
    end
  end

  private
  attr_reader :penalty

  def deduct(amount)
    raise "Your balance is #{balance}, you do not have enough for this \
transaction." if insufficient_funds?(amount) && @penalty == false
    @balance -= amount
    reset_penalty
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

  def invalid_touch_out?
    journey_history.empty? || journey_history.last.was_expecting_touch_out \
      == false
  end

  def record_penalty
    @penalty = true
    deduct(journey_history.last.calculate_penalty)
  end

  def reset_penalty
    @penalty = false
  end

  def touch_in_expected?
    journey_history.last.was_expecting_touch_in
  end

  def record_invalid_journey(station)
    journey = Journey.new
    journey_history << journey
    journey_history.last.record_exit(station)
  end
end
