require 'rspec'
require_relative 'quicksort'

describe QuickSort do
  subject { QuickSort.new }

  describe '#partition' do
    let(:high) { array.length - 1 }

    context 'given a shuffled array' do
      let(:array) { [38, 95, 61, 98, 88, 24, 13, 56, 29, 66, 93, 34] }

      it 'partitions the array, returning the index of the partition' do
        expect(subject.partition(array, 0, high)).to eq 4
      end
    end

    context 'given an array with duplicate keys' do
      let(:array) { ['B', 'B', 'A', 'A', 'B', 'A', 'A', 'A', 'B', 'A', 'B', 'A'] }

      it 'partitions the array, returning the index of the partition' do
        expect(subject.better_partition(array, 0, high)).to eq 6
      end
    end
  end
end
