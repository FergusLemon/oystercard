class JourneyLog
  NO_CHARGE = 0
  attr_reader :journey_klass

  def initialize(journey_klass = Journey)
    @journeys = []
    @journey_klass = journey_klass
  end

  def start_journey(station)
    add(journey_klass.new(station))
  end

  def end_journey(station)
    if journeys.last.in_progress?
      update_journeys(station)
    else
      add(journey_klass.new)
      update_journeys(station)
    end
  end

  def unpaid_charges
    incomplete_journey ? calculate_penalty : NO_CHARGE
  end

  def journeys
    @journeys.dup
  end

  private

  def add(journey)
    @journeys << journey
  end

  def update_journeys(station)
    journeys.last.exit(station)
  end

  def incomplete_journey
    true unless journeys.empty? || journeys.last.complete?
  end

  def calculate_penalty
    journeys.last.exit.calculate_fare
  end
end
