class Oystercard
  attr_reader :balance, :entry_station, :journey_history
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
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
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    journey_history << record_journey(station)
    reset_station_history
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

  def record_journey(station)
    journey = { @entry_station => station }
    journey
  end

  def reset_station_history
    @entry_station = nil
  end
end
