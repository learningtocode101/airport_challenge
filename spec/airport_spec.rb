require 'airport'

describe Airport do

  it 'instructs a plane to land' do
    plane = Plane.new
    expect(subject.instruct_to_land(plane)).to eq [plane]
  end

  it 'instructs a plane to take off and confirm it has' do
    expect { subject.instruct_to_takeoff(Plane.new) }.equal? true
  end

end
