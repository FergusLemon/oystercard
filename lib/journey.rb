class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    @entry_station = station
    @complete = false
  end

  def exit(station = nil)
    @exit_station = station
    @complete = true
    self
  end

  def calculate_fare
    penalty? ? PENALTY_FARE : MIN_FARE
  end

  def complete?
    @complete
  end


  private

  def penalty?
    (!entry_station || !exit_station)
  end
end
