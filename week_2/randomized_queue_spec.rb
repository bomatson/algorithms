require 'rspec'
require_relative 'randomized_queue'

describe RandomizedQueue do
  subject { RandomizedQueue.new }

  before do
    srand(67809)
  end

  describe '#enqueue' do
    context 'given an empty list' do
      before do
        subject.enqueue('here I am')
      end

      it 'adds the item to the list' do
        expect(subject.items).to eq ['here I am']
      end

      it 'increments the count' do
        expect(subject.tail).to eq 1
      end
    end

    context 'given e list with items' do
      before do
        subject.enqueue('here I am')
        subject.enqueue('there I am')
        subject.enqueue('where am I')
      end

      it 'adds the item to the beginning of the list' do
        expect(subject.items).to eq ['where am i', 'there I am', 'here I am']
      end
    end
  end

  describe '#dequeue' do
    context 'given an empty list' do
      it 'returns nil' do
        expect(subject.dequeue).to be_nil
      end
    end

    context 'given a list with two items' do
      before do
        subject.enqueue('hi there')
        subject.enqueue('bye there')
      end

      it 'returns a random element from the queue' do
        expect(subject.dequeue).to eq 'hi there'
      end

      it 'decrements the tail count' do
        subject.dequeue
        expect(subject.tail).to eq 1
      end
    end
  end

  describe '#sample' do
    context 'given an empty list' do
      it 'returns nil' do
        expect(subject.sample).to be_nil
      end
    end

    context 'given a list with two items' do
      before do
        subject.enqueue('hi there')
        subject.enqueue('bye there')
      end

      it 'returns a random element from the queue' do
        expect(subject.sample).to eq 'hi there'
      end

      it 'keeps the item in the queue' do
        subject.sample
        expect(subject.tail).to eq 2
      end

      it 'preserves the queue order' do
        subject.sample
        expect(subject.items).to eq ['hi there', 'bye there']
      end
    end
  end
end
