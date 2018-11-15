class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, journey_log = JourneyLog.new)
    raise "The balance is not valid. Please try again with a whole number\
 between £#{DEFAULT_BALANCE} and £#{MAX_BALANCE}." unless balance.is_a? Integer
    raise 'An oystercard cannot start with a negative balance.' if \
      balance < DEFAULT_BALANCE
    @balance = balance
    @journey_log = journey_log
  end

  def top_up(amount)
    raise "Sorry the maximum balance is #{MAX_BALANCE}, please try topping up \
a lower amount." if max_balance_hit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Your balance (£#{balance}) is insufficient, you need a balance \
of £#{MIN_FARE} to travel." if low_balance?
    deduct(journey_log.unpaid_charges)
    journey_log.start_journey(station)
    self
  end

  def touch_out(station)
    raise "You have a negative balance of (£#{balance}), please top up at \
least £#{-balance + MIN_FARE} before making your journey." if negative_balance?
    journey = journey_log.end_journey(station)
    deduct(journey.calculate_fare)
  end

  private

  attr_reader :journey_log

  def deduct(amount)
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

  def negative_balance?
    balance < 0
  end
end
