require 'journey'
require 'oystercard'

describe Journey do
  let(:entry_station) {:entry_station}
  let(:exit_station) {:exit_station}

  context ' #new' do
    it 'creates a Journey object' do
      expect(subject).to be_instance_of Journey
    end
  end

  context 'just touched in' do
    describe '#start_journey' do
      it 'start records an entry station' do
        expect(subject.start_journey(entry_station)).to eq entry_station
      end

      it 'sets in_journey status to true' do
        subject.start_journey(entry_station)
        expect(subject.in_journey?).to eq true
      end
    end

    context 'already in journey' do
      it 'records exit_station as incomplete journey' do
        subject.start_journey(entry_station)
        expect(subject.start_journey(entry_station)).to eq 'incomplete journey'
      end
    end
  end

  context 'just touched out' do
    describe 'end_journey' do
      it 'records an exit station' do
        subject.start_journey(entry_station)
        expect(subject.end_journey(exit_station)).to eq exit_station
      end

      it 'sets in_journey status to false' do
        subject.start_journey(entry_station)
        subject.end_journey(exit_station)
        expect(subject.in_journey?).to eq false
      end

      context 'not in journey' do
        it 'records entry_station as incomplete journey' do
          expect(subject.end_journey(exit_station)).to eq 'incomplete journey'
        end
      end
    end
  end

  context 'calculate fair' do
    context 'complete journey' do
      before do
        subject.start_journey(entry_station)
        subject.end_journey(exit_station)
      end

      it 'records the fair minimum amount' do
        expect(subject.calculate_fair).to eq Oystercard::MINIMUM_AMOUNT
      end
    end

    context 'incomplete journey two start journeys' do
      before do
        subject.start_journey(entry_station)
        subject.start_journey(entry_station)
      end

      it 'records penalty fair' do
        expect(subject.calculate_fair).to eq Oystercard::PENALTY_FAIR
      end
    end

    context 'incomplete journey two end journeys' do
      before do
        subject.end_journey(exit_station)
        subject.end_journey(exit_station)
      end

      it 'records penalty fair' do
        expect(subject.calculate_fair).to eq Oystercard::PENALTY_FAIR
      end
    end
  end
end
