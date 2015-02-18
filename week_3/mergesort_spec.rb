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

  describe '#sort' do
    context 'given an unsorted array' do
      let(:actual) { [89, 10, 78, 31, 94, 63, 50, 35, 53, 15, 46, 44 ] }

      it 'returns a sorted array' do
        p subject.merge_sort(actual)
        # expect(subject.actual).to eq [2,4,5,6,7,8,8,10]
      end
    end
  end
end
