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

  def dequeue
    array = []
    current = @head

    @node_count.times do |i|
      array[i] = current
      current = current.next
    end

    shuffle!(array)

    @head = @tail = nil
    @node_count = 0

    array.each do |node|
      enqueue(node.item)
    end

    item = @tail.item
    @tail = @tail.prev

    @node_count -= 1
    item
  end

  def sample
    array = []
    current = @head

    @node_count.times do |i|
      array[i] = current
      current = current.next
    end

    shuffle!(array)

    array.first.item
  end

  def iterator
    @iterator ||= Iterator.new(@head)
  end

  private

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

  # def shuffle
  #   array = []
  #   current_node = @head

  #   while current_node.next != nil do
  #     array[i
  #   end
  #     array[i] = current

  #   array.shuffle!

  #   array.each do

  #   end
  # end
end
