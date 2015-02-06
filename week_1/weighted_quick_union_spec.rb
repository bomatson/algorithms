require 'rspec'
require_relative 'weighted_quick_union'

describe WeightedQuickUnion do
  xdescribe 'weighted?' do
    subject { WeightedQuickUnion.new 10 }

    context 'given an array with a cycle' do
      before do
        subject.ids = [4, 0, 0, 0, 5, 8, 8, 0, 0, 0]
      end

      it 'returns false' do
        expect(subject.weighted?).to eq false
      end
    end
  end
end
