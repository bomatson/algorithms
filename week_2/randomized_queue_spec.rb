require 'rspec'
require_relative 'randomized_queue'

describe RandomizedQueue do
  subject { RandomizedQueue.new }

  describe 'on initialize' do
    it 'has no values at the head' do
      expect(subject.head).to be_nil
    end

    it 'has no values at the tail' do
      expect(subject.tail).to be_nil
    end
  end

  describe '#enqueue' do
    context 'without any nodes' do
      before do
        subject.enqueue('magic stuff')
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
        subject.enqueue('magic stuff')
        subject.enqueue('more magic stuff')
        subject.enqueue('me first')
      end

      it 'creates a new node as the head' do
        expect(subject.head.item).to eq 'me first'
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
        subject.enqueue('magic stuff')
        subject.enqueue('me first')
      end

      it 'returns false' do
        expect(subject.is_empty?).to eq false
      end
    end
  end

  describe '#sample' do
    context 'with a group of nodes' do
      before do
        subject.enqueue('magic stuff')
        subject.enqueue('fine i will be last')
        subject.enqueue('me first')
      end

      it 'returns a random item' do
        expect(subject.sample).to eq 'hi'
      end
    end
  end

  describe '#dequeue' do
    context 'with a group of nodes' do
      before do
        subject.enqueue('magic stuff')
        subject.enqueue('fine i will be last')
        subject.enqueue('me first')
      end

      it 'returns a random item' do
        expect(subject.dequeue).to eq 'hi'
      end

      it 'decrements the node count' do
        subject.dequeue
        expect(subject.node_count).to eq 2
      end
    end
  end

  xdescribe '#iterator' do
    context 'given existing items' do
      before do
        subject.add_first('hi there')
        subject.add_first('helllloo there')
        subject.add_last('magic stuff')
      end

      it 'returns an iterator' do
        expect(subject.iterator).to be_kind_of Iterator
      end

      it 'walks through the queue from the front to back' do
        expect(subject.iterator.next).to eq 'helllloo there'
        expect(subject.iterator.next).to eq 'hi there'
        expect(subject.iterator.next).to eq 'magic stuff'
      end
    end
  end
end
