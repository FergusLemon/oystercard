class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    @entry_station = station
    @exit_station = nil
  end

  def record_exit(station)
    @exit_station = station
  end

  def calculate_fare
    MIN_FARE
  end

  def calculate_penalty
    PENALTY_FARE
  end

  def complete?
   true if entry_station && exit_station
  end

  def was_expecting_touch_in
    self.complete? || (self.entry_station == nil && self.exit_station != nil)
  end

  def was_expecting_touch_out
    self.entry_station != nil && self.exit_station == nil
  end
end
