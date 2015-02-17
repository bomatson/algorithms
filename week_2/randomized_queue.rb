require 'byebug'

class RandomizedQueue
  attr_reader :items, :tail

  def initialize
    @items = []
    @tail = 0
  end

  def size
    @tail
  end

  def is_empty?
    @tail == 0
  end

  def enqueue(item)
    if @tail == @items.length
      resize(2 * @tail)
    end

    # this is enqueuing at the end?
    # would make more sense to be at the beginning..

    @items[@tail] = item
    @tail += 1
  end

  def dequeue
    if @tail > 0

      if (@items.length / 4) == @tail
        resize(@items.length / 2)
      end

      random_index = rand(@tail)

      item_to_dequeue = @items[random_index]
      @items[random_index] = @items[@tail]
      @items[@tail] = nil
      @tail -= 1

      item_to_dequeue
    end
  end

  def sample
    random_index = rand(@tail)

    @items[random_index]
  end

  def resize(length)
    copy = Array.new(length)

    length.times do |i|
      copy[i] = @items[i]
    end

    @items = copy
  end
end
