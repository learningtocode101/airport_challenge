require'airport'

describe Airport do
  subject(:airport) { described_class.new }
  it 'instructs a plane to land' do
    plane = Plane.new
    expect(airport.instruct_to_land(plane)).to eq [plane]
    expect { airport.instruct_to_land(plane) }.to raise_error('Plane already landed')
  end

  it 'instructs a plane to take off' do
    plane = Plane.new
    expect { airport.instruct_to_takeoff(plane) }.equal? true
    expect { airport.instruct_to_takeoff(plane) }.to raise_error('Plane already took off')
  end

  it "sets default capacity of airport" do
    expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
  end

  it "does not allow plane to land when airport is full" do
    airport.capacity.times { subject.instruct_to_land Plane.new }
    expect { airport.instruct_to_land(Plane.new) }.to raise_error("Airport is full")
  end

  it "raises an error when weather is stormy" do

  end
end
