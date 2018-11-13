class JourneyLog
  attr_reader :journeys, :journey_klass

  def initialize(journey_klass = Journey)
    @journeys = []
    @journey_klass = journey_klass
  end

  private
end
