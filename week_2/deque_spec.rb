require 'rspec'
require_relative 'deque'

describe Deque do
  subject { Deque.new }

  describe 'initialization' do
    it 'assigns items an empty array' do
      expect(subject.items).to eq []
    end
  end

  describe '#is_empty?' do
    context 'given no items in the deque' do
      it 'returns true' do
        expect(subject.is_empty?).to eq true
      end
    end

    context 'given some items in the deque' do
      before do
        subject.add_first('hi there')
      end

      it 'returns false' do
        expect(subject.is_empty?).to eq false
      end
    end
  end

  describe '#add_first' do
    context 'given existing items' do
      before do
        subject.add_first('hi there')
        subject.add_first('helllloo there')
      end

      it 'adds a new item to the beginning of the queue' do
        subject.add_first('something new')
        expect(subject.items.first).to eq 'something new'
      end
    end
  end

  describe '#add_last' do
    context 'given existing items' do
      before do
        subject.add_first('hi there')
        subject.add_first('helllloo there')
      end

      it 'adds a new item to the end of the queue' do
        subject.add_last('something new')
        expect(subject.items.last).to eq 'something new'
      end
    end
  end

  describe '#size' do
    context 'given existing items' do
      before do
        subject.add_first('hi there')
        subject.add_first('helllloo there')
      end

      it 'returns the size of the deque' do
        expect(subject.size).to eq 2
      end
    end
  end

  describe '#remove_first' do
    context 'given existing items' do
      before do
        subject.add_first('hi there')
        subject.add_first('helllloo there')
      end

      it 'returns the first element' do
        expect(subject.remove_first).to eq 'helllloo there'
      end

      it 'removes it from the deque' do
        subject.remove_first
        expect(subject.size).to eq 1
      end
    end
  end

  describe '#remove_last' do
    context 'given existing items' do
      before do
        subject.add_first('hi there')
        subject.add_first('helllloo there')
      end

      it 'returns the last element' do
        expect(subject.remove_last).to eq 'hi there'
      end

      it 'removes it from the deque' do
        subject.remove_last
        expect(subject.size).to eq 1
      end
    end
  end

  describe '#iterator' do
    context 'given existing items' do
      before do
        subject.add_first('hi there')
        subject.add_first('helllloo there')
      end

      it 'returns an iterator' do
        expect(subject.iterator).to be_kind_of Enumerator
      end

      it 'walks through the queue from the front' do
        expect(subject.iterator.next).to eq 'helllloo there'
      end
    end
  end
end
