class Journey
  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    @entry_station = station
    @exit_station = nil
  end

  def record_exit(station)
    @exit_station = station
  end

  def complete?
   true if entry_station && exit_station
  end
end
