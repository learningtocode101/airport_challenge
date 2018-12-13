require 'plane'

describe 'Plane' do
  subject(:plane) { Plane.new }

  it "knows it's a plane" do
    expect(plane).to eq plane
  end
end
