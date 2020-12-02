require 'station'

describe Station do
  let(:zone) {1}
  let(:name) {"Waterloo"}
  let(:station) {Station.new(name, zone)}

  context 'on creation' do
    it 'should accept name and zone arguments' do
      expect(station).to be_instance_of Station
    end
  end

  context 'once created' do
    it 'should allow customers to know the name of the station' do
      expect(station.name).to eq name
    end

    it 'should allow customers to know what zone the station is in' do
      expect(station.zone).to eq zone
    end
  end
end
