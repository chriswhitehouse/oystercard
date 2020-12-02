require 'oystercard'
require 'journey'
require 'station'

describe Oystercard do
  let (:entry_station) {Station.new("Waterloo", 1)}
  let (:exit_station) {Station.new("Mordon", 5)}


  shared_context 'fully topped up oystercard and touched in' do
    before do
      @balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(@balance_limit)
      subject.touch_in(entry_station)
    end
  end

  shared_context 'fully topped up oystercard and touched in and touched out' do
    before do
      @balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(@balance_limit)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end
  end

  it "Should be an instance of the Oystercard class" do
    expect(subject).to be_instance_of Oystercard
  end

  describe '#balance' do
    it "Checks if the new card has a 0 balance" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should add amount to balance' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end
  end

  describe '#top_up with full card' do
    include_context "fully topped up oystercard and touched in"

    it 'Throws an exception if balance limit is exceeded' do
      expect{ subject.top_up(1) }.to raise_error "Can't exceed the limit of £#{@balance_limit}"
    end
 end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject.journey).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'can touch in' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(entry_station)
      expect(subject.journey).to be_in_journey
    end

    it 'throws an error if balance is less than minimum amount' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient balance on card"
    end
  end

  describe '#touch_out' do
    include_context "fully topped up oystercard and touched in"

    it 'can touch out' do
      subject.touch_out(exit_station)
      expect(subject.journey).not_to be_in_journey
    end

    it 'deducts amount from balance for journey' do
      expect {subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MINIMUM_AMOUNT)
    end

    it "forgets the entry station" do
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end
  end

  describe '#journeys' do
    it 'returns an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#journeys after touch in' do
    include_context 'fully topped up oystercard and touched in and touched out'

    it 'returns all previous journeys' do
      expect(subject.journeys).to include instance_of Journey
    end

    it 'touching in and out creates one journey' do
      expect(subject.journeys.count).to eq 1
    end
  end
end
