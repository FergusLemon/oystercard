class JourneyLog
  attr_reader :journeys, :journey_klass

  def initialize(journey_klass = Journey)
    @journeys = []
    @journey_klass = journey_klass
  end

  def start_journey(station)
    journey = journey_klass.new(station)
    journeys << journey
  end

  def end_journey(station)
    journeys.last.record_exit(station)
  end

  def unpaid_charges
    incomplete_journey ? 6 : 0
  end

  private

  def incomplete_journey
    journeys.last.complete == false
  end
end
