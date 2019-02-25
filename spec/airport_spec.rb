require 'airport'

describe Airport do
  subject(:airport) { described_class.new(capacity, weatherstation) }
  let(:plane) { Plane.new }
  let(:capacity) { double :capacity }
  let(:weatherstation) { WeatherStation.new }

  it "knows its capacity" do
    expect(airport.capacity).to eq(capacity)
  end

  describe '#land' do
    before { allow(weatherstation).to receive(:stormy?).and_return false }
    context 'clear weather' do
      it 'instructs a plane to land' do
        expect(airport).to respond_to(:instruct_to_land).with(1).argument
        expect(airport.instruct_to_land(plane)).to eq [plane]
        expect { airport.instruct_to_land(Plane.new) }.to_not raise_error
      end
      context 'plane already landed' do
        it 'raises an error' do
          airport.instruct_to_land(plane)
          expect { airport.instruct_to_land(plane) }.to raise_error('Plane already landed')
        end
      end
      context 'when full' do
        it 'raises an error' do
          airport = Airport.new(20, weatherstation)
          20.times { airport.instruct_to_land(Plane.new) }
          expect { airport.instruct_to_land(Plane.new) }.to raise_error("Airport is full")
        end
      end
    end
    context 'stormy weather' do
      it "raises an error" do
        allow(weatherstation).to receive(:stormy?).and_return true
        expect { airport.instruct_to_land(plane) }.to raise_error('Too stormy to land')
      end
    end
  end

  describe '#takeoff' do
    before { allow(weatherstation).to receive(:stormy?).and_return false }
    context 'clear weather' do
      it 'instructs a plane to take off' do
        airport.instruct_to_land(plane)
        expect { airport.instruct_to_takeoff(plane) }.equal? true
      end
      context 'plane not available' do
        it 'raises an error' do
          allow(airport).to receive(:at_airport?).and_return false
          expect { airport.instruct_to_takeoff(plane) }.to raise_error('Plane already took off')
        end
      end
    end
    context 'stormy weather' do
      it "raises an error" do
        allow(airport).to receive(:at_airport?).and_return true
        allow(weatherstation).to receive(:stormy?).and_return true
        expect { airport.instruct_to_takeoff(plane) }.to raise_error('Too stormy to takeoff')
      end
    end
  end

end
