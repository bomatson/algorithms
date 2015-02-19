require 'rspec'
require_relative 'mergesort'

describe MergeSort do
  subject { MergeSort.new }

  xdescribe '#merge' do
    context 'given two sorted arrays' do
      let(:actual) { [5,6,9,10,4,5,6,7] }

      it 'returns a sorted array' do
        subject.merge([], 0, 3, 8)
        expect(subject.actual).to eq [4,5,5,6,6,7,9,10]
      end
    end
  end

  xdescribe '#merge_sort' do
    context 'given an unsorted array' do
      let(:actual) { [42, 60, 59, 40, 75, 65, 57, 43, 30, 29, 10, 53] }

      it 'returns a sorted array' do
        p subject.merge_sort(actual)
        # expect(subject.actual).to eq [2,4,5,6,7,8,8,10]
      end
    end
  end

  describe '#bottom_up' do
    context 'given an unsorted array' do
      let(:actual) { [17, 11, 68, 79, 36, 13, 33, 35, 99, 91] }

      it 'returns a sorted array' do
        p subject.bottom_up_merge_sort(actual)
        # expect(subject.actual).to eq [2,4,5,6,7,8,8,10]
      end
    end
  end
end
