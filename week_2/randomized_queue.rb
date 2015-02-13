require 'byebug'
require_relative 'iterator'

class RandomizedQueue
  attr_reader :head, :tail, :node_count

  Node = Struct.new(:item, :prev, :next)

  def initialize
    @head = nil
    @tail = nil
    @node_count = 0
  end

  def enqueue(item)
    if @head
      @head.prev = Node.new(item, nil, @head)
      @head = @head.prev
    else
      @head = @tail = Node.new(item)
    end

    @node_count += 1
  end

  def is_empty?
    @head == nil
  end

  def size
    @node_count
  end

  def sample
    shuffled_array[@node_count - 1].item
  end

  def dequeue
    shuffled_array
    rethread_with(shuffled_array)

    item = @tail.item
    @tail = @tail.prev

    @node_count -= 1
    item
  end

  def iterator
    shuffled_array
    rethread_with(shuffled_array)

    @iterator ||= Iterator.new(@head)
  end

  private

  def rethread_with(array)
    @head = @tail = nil
    @node_count = 0

    array.each do |node|
      enqueue(node.item)
    end
  end

  def shuffled_array
    array = []
    current = @head

    @node_count.times do |i|
      array[i] = current
      current = current.next
    end

    shuffle!(array)

    array
  end

  def shuffle!(array)
    n = array.size

    n.times do |i|
      random = rand(i + 1)
      exchange(array, i, random)
    end
  end

  def exchange(array, i, j)
    swap = array[i]
    array[i] = array[j]
    array[j] = swap
  end
end
