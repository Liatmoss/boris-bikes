require 'bike'

describe Bike do
  
  it 'can be reported broken' do
    subject.report_broken
    expect(subject).to be_broken
  end

  it { is_expected.to respond_to :broken?}

end
