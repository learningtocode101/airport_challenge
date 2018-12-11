require 'airport'

describe Airport do
  subject(:airport) { described_class.new(capacity) }
  let(:plane) { double :plane }
  let(:capacity) { double :capacity }

  it "knows it's capacity" do
    expect(airport.capacity).to eq(capacity)
  end

  describe '#land' do
    it 'instructs a plane to land' do
      allow(airport).to receive(:stormy?).and_return false
      expect(airport).to respond_to(:instruct_to_land).with(1).argument
      expect(airport.instruct_to_land(plane)).to eq [plane]
    end
    context 'airport full' do
      it 'raises an error' do
        an_airport = Airport.new(20)
        allow(an_airport).to receive(:stormy?).and_return false
        20.times { an_airport.instruct_to_land(Plane.new) }
        expect { an_airport.instruct_to_land(Plane.new) }.to raise_error("Airport is full")
      end
    end
    context 'plane already landed' do
      it 'raises an error' do
        allow(airport).to receive(:stormy?).and_return false
        airport.instruct_to_land(plane)
        expect { airport.instruct_to_land(plane) }.to raise_error('Plane already landed')
      end
    end
  end

  describe '#takeoff' do
    it 'instructs a plane to take off' do
      expect { airport.instruct_to_takeoff(plane) }.equal? true
    end
    context 'plane not available' do
      it 'raise an error' do
        expect { airport.instruct_to_takeoff(plane) }.to raise_error('Plane not available for take off')
      end
    end
    context 'airport is empty' do
      it "raises an error" do
        allow(airport).to receive(:stormy?).and_return false
        allow(airport).to receive(:empty?).and_return true
        airport.instruct_to_land(plane)
        expect { airport.instruct_to_takeoff(plane) }.to raise_error("Airport is empty")
      end
    end
  end

  context 'stormy' do
    it "raises an error" do
      allow(airport).to receive(:stormy?).and_return true
      expect { airport.instruct_to_land(plane) }.to raise_error('Too stormy to land')
    end
  end

end
