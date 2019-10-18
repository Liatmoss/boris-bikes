require 'docking_station'

describe DockingStation do

  it 'returns docked bikes' do
    bike = double :bike
    subject.dock(bike)
    expect(subject.bike).to eq @bikes
  end

  describe '#release_bike' do
    it 'releases a bike' do
      bike = double(:bike, broken?: false)
      subject.dock bike
      expect(subject.release_bike).to be bike
    end

    it 'should raise an error if bike is broken' do
      bike = double(:bike, broken?: true)
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error 'This bike is broken'
    end

    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error 'No bikes available'
    end
  end

  describe '#dock' do
    it 'raises an error when full' do
      subject.capacity.times { subject.dock double :bike }
      expect { subject.dock double(:bike) }.to raise_error 'Docking station full'
    end

    it "accepts broken bikes" do
      bike = double :bike, broken?: true, working?: false
      subject.dock(bike)
      expect(subject.bike).to eq(@bikes)
    end

    it 'has a default capacity' do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end
  end

  describe 'initialization' do
    subject { DockingStation.new }
    let(:bike) {double :bike }
    it 'defaults capacity' do
      described_class::DEFAULT_CAPACITY.times do
        subject.dock(bike)
      end
      expect{ subject.dock(bike) }.to raise_error 'Docking station full'
    end
  end
end
