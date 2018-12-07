require'airport'

describe Airport do
  subject(:airport) { described_class.new(Airport::DEFAULT_CAPACITY) }
  let(:plane) { double :plane}

  describe '#land' do
    it 'instructs a plane to land' do
      expect(airport).to respond_to(:instruct_to_land).with(1).argument
      expect(airport.instruct_to_land(plane)).to eq [plane]
    end
    context 'airport full' do
      it 'raises an error' do
        airport.capacity.times { airport.instruct_to_land(Plane.new)}
        expect { airport.instruct_to_land(plane) }.to raise_error("Airport is full")
      end
    end
    context 'plane already landed' do
      it 'raises an error when plane already landed' do
        airport.instruct_to_land(plane)
        expect { airport.instruct_to_land(plane) }.to raise_error('Plane already landed')
      end
    end
  end

  describe '#takeoff' do
    it 'instructs a plane to take off' do
      expect { airport.instruct_to_takeoff(plane) }.equal? true
    end
    context 'plane already took off' do
      it 'raise an error' do
        expect { airport.instruct_to_takeoff(plane) }.to raise_error('Plane already took off')
      end
    end
  end

  it "allows setting capacity of airport" do
    expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
  end

end
