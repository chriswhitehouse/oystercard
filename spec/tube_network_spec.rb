require 'tube_network'

describe TubeNetwork do
  describe Station do
    context 'creation' do
      let(:zone) {1}
      let(:name) {"Waterloo"}
      let(:station) {Station.new(name, zone)}

      it 'should accept name and zone arguments' do
        expect(station).to be_instance_of Station
      end
    end
  end

  describe Oystercard do
    context 'creation' do
      it "should be an instance of the Oystercard class" do
        expect(subject).to be_instance_of Oystercard
      end
    end
  end
end
