require './lib/oystercard'

describe Oystercard do

  it "is initialized with balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up balance' do
      expect{ subject.top_up(1)}.to change{subject.balance}.by 1
    end

    it 'raises error if maximum is exceeded' do
      max_balance = Oystercard::MAX_LIMIT
      subject.top_up(max_balance)
      expect{ subject.top_up 1}.to raise_error 'Maximum balance exceeded. Max limit is £90'
    end
  end

  describe '#deduct' do
    let(:station){double :station}

    it 'fair is deducted when touching in' do
      subject.top_up 20
      expect {subject.touch_in(station)}.to change{subject.balance}.by(-1)
    end
  end

  describe '#journey' do
    let(:entry_station){double :station}
    let(:exit_station){double :station}

    it 'is not in journey when initialized' do
      expect(subject.in_journey).to be false
    end

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'can touch in' do
      subject.top_up 20
      subject.touch_in(entry_station)
      expect(subject.in_journey).to be true
    end

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'can touch out' do
      subject.top_up 20
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey).to be false
    end

    it 'raises error if minimum is reached' do
      min_balance = Oystercard::MIN_LIMIT
      expect { subject.touch_in(entry_station)}.to raise_error 'Please top up. Current balance is £0'
    end
  end

  describe '#station' do
    let(:entry_station){double :station}
    let(:exit_station){double :station}

    it 'stores the entry station' do
      subject.top_up 20
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it 'touches out of a station' do
      subject.top_up 20
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    it 'entry station is nil after checking out' do
      subject.top_up 20
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end
  end

  describe '#journeys' do
    # let(:journey) { {entry_station: entry_station, exit_station: exit_station}}
    let(:entry_station){double :station}
    let(:exit_station){double :station}

    it 'holds a journey log' do
      expect(subject.journey).to be_empty
    end

    it 'entry station is added to hash when checked in' do
      subject.top_up 20
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey).to include entry_station
      expect(subject.journey).to include exit_station
    end

  end

end
