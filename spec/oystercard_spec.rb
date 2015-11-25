require './oystercard'

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
    it 'fair is deducted when touching in' do
      subject.top_up 20
      expect {subject.touch_in_out}.to change{subject.balance}.by(-1)
    end
  end

  describe '#journey' do
    it 'is not in journey when initialized' do
      expect(subject.in_journey).to be false
    end

    it 'can touch in' do
      subject.top_up 20
      subject.touch_in_out
      expect(subject.in_journey).to be true
    end

    it 'can touch out' do
      subject.top_up 20
      subject.touch_in_out
      subject.touch_in_out
      expect(subject.in_journey).to be false
    end

    it 'raises error if minimum is reached' do
      min_balance = Oystercard::MIN_LIMIT
      expect { subject.touch_in_out}.to raise_error 'Please top up. Current balance is £0'
    end
  end

end
