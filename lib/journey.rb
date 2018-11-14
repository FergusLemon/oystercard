class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    @entry_station = station
    @compelte = false
  end

  def exit(station = nil)
    @exit_station = station
    @complete = true
  end

  def calculate_fare
    penalty? ? PENALTY_FARE : MIN_FARE
  end

  def calculate_penalty
    PENALTY_FARE
  end

  def complete?
    @complete
  end

  def was_expecting_touch_in
    self.complete? || (self.entry_station == nil && self.exit_station != nil)
  end

  def was_expecting_touch_out
    self.entry_station != nil && self.exit_station == nil
  end

  private

  def penalty?
    (!entry_station || !exit_station)
  end
end
