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
  private
end
