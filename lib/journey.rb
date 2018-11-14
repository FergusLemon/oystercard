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
    penalty? ? PENALTY_FARE : calculate_zone_charge
  end

  def complete?
    @complete
  end

  def in_progress?
    entry_station && !exit_station
  end

  private

  def penalty?
    (!entry_station || !exit_station)
  end

  def calculate_zone_charge
    zone_fare = (entry_station.zone - exit_station.zone).abs
    MIN_FARE + zone_fare
  end
end
