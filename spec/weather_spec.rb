require 'weatherstation'
require 'airport'
describe WeatherStation do

  subject(:weatherstation) { described_class.new }

  describe 'weather status' do
    it "when stormy" do
      allow(weatherstation).to receive(:stormy?).and_return true
      expect(weatherstation.stormy?).to be true
    end
    it "when clear weather" do
      allow(weatherstation).to receive(:stormy?).and_return false
      expect(weatherstation.stormy?).to be false
    end
  end

end
