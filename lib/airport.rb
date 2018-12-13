require 'weatherstation'
class Airport
  DEFAULT_CAPACITY = 10

  attr_reader :capacity
  def initialize(capacity = DEFAULT_CAPACITY, weatherstation)
    @capacity = capacity
    @weatherstation = weatherstation
    @planes = []
  end

  def instruct_to_land(plane)
    fail "Airport is full" if full?
    raise "Plane already landed" if at_airport?(plane)
    raise "Too stormy to land" if stormy?
    @planes.push(plane)
  end

  def instruct_to_takeoff(plane)
    raise "Plane already took off" unless at_airport?(plane)
    raise "Too stormy to takeoff" if stormy?
    @planes.delete(plane)
  end

private
  def full?
    @planes.count == capacity
  end

  def at_airport?(plane)
    @planes.include?(plane)
  end

  def stormy?
    @weatherstation.stormy?
  end

end
