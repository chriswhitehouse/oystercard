require 'oystercard'

describe Oystercard do

  shared_context 'fully topped up oystercard' do
    before do
      @balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(@balance_limit)
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
    include_context "fully topped up oystercard"

    it 'Throws an exception if balance limit is exceeded' do
      expect{ subject.top_up(1) }.to raise_error "Can't exceed the limit of £#{@balance_limit}"
    end
 end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'can touch in' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'throws an error if balance is less than minimum amount' do
      expect{ subject.touch_in }.to raise_error "Insufficient balance on card"
    end
  end

  describe '#touch_out' do
    include_context "fully topped up oystercard"

    it 'can touch out' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deducts amount from balance for journey' do
      subject.touch_in
      expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_AMOUNT)
    end
  end

end
