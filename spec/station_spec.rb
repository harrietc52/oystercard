require './lib/station'

describe Station do

  let(:bank){Station.new("Bank", 1)}

  it 'knows its name' do
    expect(bank.name).to eq "Bank"
  end

  it 'knows its zone' do
    expect(bank.zone).to eq 1
  end

end
