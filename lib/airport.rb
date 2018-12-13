require 'weatherstation'
class Airport
  DEFAULT_CAPACITY = 10

  attr_reader :capacity
  def initialize(capacity = DEFAULT_CAPACITY)
    @planes = []
    @capacity = capacity
  end

  def instruct_to_land(plane)
    fail "Airport is full" if full?
    raise "Plane already landed" if @planes.include?(plane)
    raise "Too stormy to land" if stormy?
    @planes.push(plane)
  end

  def instruct_to_takeoff(plane)
    raise "Plane not available for take off" unless @planes.include?(plane)
    raise "Airport is empty" if empty?
    @planes.delete(plane)
  end

private
  def full?
    @planes.count == capacity
  end

  def empty?
    @planes.count == 0
  end
end
