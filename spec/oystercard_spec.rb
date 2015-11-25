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
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct amount from balance' do
      expect { subject.deduct(1)}.to change{subject.balance}.by(-1)
    end

  end

end
