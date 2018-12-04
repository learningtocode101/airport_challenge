require 'airport'

describe Airport do

  it 'instructs a plane to land' do
    plane = Plane.new
    expect(subject.instruct_to_land(plane)).to eq [plane]
    expect(subject.instruct_to_land(plane).to raise_error('Plane already landed'))
  end

  it 'instructs a plane to take off and confirm it has' do
    expect { subject.instruct_to_takeoff(Plane.new) }.equal? true
    expect(subject.instruct_to_takeoff(Plane.new).to raise_error('Plane already took off'))
  end

end
