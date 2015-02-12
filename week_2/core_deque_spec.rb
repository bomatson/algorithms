require 'rspec'
require_relative 'core_deque'

describe CoreDeque do
  subject { CoreDeque.new }

  describe 'on initialize' do
    it 'has no values at the head' do
      expect(subject.head).to be_nil
    end

    it 'has no values at the tail' do
      expect(subject.tail).to be_nil
    end
  end

  describe '#add_first' do
    context 'without any nodes' do
      before do
        subject.add_first('magic stuff')
      end

      it 'assigns the same node to head and tail' do
        expect(subject.head).to eq subject.tail
      end

      it 'increments the node count' do
        expect(subject.node_count).to eq 1
      end
    end

    context 'with a group of nodes' do
      before do
        subject.add_first('magic stuff')
        subject.add_first('more magic stuff')
        subject.add_first('me first')
      end

      it 'creates a new node as the head' do
        expect(subject.head.item).to eq 'me first'
      end
    end
  end

  describe '#add_last' do
    context 'without any nodes' do
      before do
        subject.add_last('magic stuff')
      end

      it 'assigns the same node to head and tail' do
        expect(subject.head).to eq subject.tail
      end

      it 'increments the node count' do
        expect(subject.node_count).to eq 1
      end
    end

    context 'with a group of nodes' do
      before do
        subject.add_last('magic stuff')
        subject.add_last('fine i will be last')
        subject.add_first('me first')
      end

      it 'creates a new node as the tail' do
        expect(subject.tail.item).to eq 'fine i will be last'
      end
    end
  end

  describe '#remove_last' do
    context 'without any nodes' do
      it 'returns nil' do
        expect(subject.remove_last).to be_nil
      end
    end

    context 'with a group of nodes' do
      before do
        subject.add_last('magic stuff')
        subject.add_last('fine i will be last')
        subject.add_first('me first')
      end

      it 'returns the last item' do
        expect(subject.remove_last).to eq 'fine i will be last'
      end

      it 'decrements the node count' do
        subject.remove_last
        expect(subject.node_count).to eq 2
      end
    end
  end

  describe '#remove_first' do
    context 'without any nodes' do
      it 'returns nil' do
        expect(subject.remove_first).to be_nil
      end
    end

    context 'with a group of nodes' do
      before do
        subject.add_last('magic stuff')
        subject.add_last('fine i will be last')
        subject.add_first('me first')
      end

      it 'returns the first item' do
        expect(subject.remove_first).to eq 'me first'
      end

      it 'decrements the node count' do
        subject.remove_first
        expect(subject.node_count).to eq 2
      end
    end
  end

  describe 'is_empty?' do
    context 'without any new nodes' do
      it 'returns true' do
        expect(subject.is_empty?).to eq true
      end
    end

    context 'with a few nodes' do
      before do
        subject.add_first('magic stuff')
        subject.add_first('me first')
      end

      it 'returns false' do
        expect(subject.is_empty?).to eq false
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

