class JourneyLog
  NO_CHARGE = 0
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
    journeys.last.exit(station)
  end

  def unpaid_charges
    incomplete_journey ? calculate_penalty : NO_CHARGE
  end

  private

  def incomplete_journey
    journeys.last.complete? == false
  end

  def calculate_penalty
    journeys.last.exit.calculate_fare
  end
end
