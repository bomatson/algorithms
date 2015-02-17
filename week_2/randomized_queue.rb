require_relative 'random_iterator'

class RandomizedQueue
  attr_reader :items, :current

  def initialize
    @items = []
    @current = 0
  end

  def size
    @current
  end

  def is_empty?
    @current == 0
  end

  def enqueue(item)
    if @current == @items.length
      resize(2 * @current)
    end

    @items[@current] = item
    @current += 1
  end

  def dequeue
    if @current > 0

      if (@items.length / 4) == @current
        resize(@items.length / 2)
      end

      random_index = rand(@current)

      item_to_dequeue = @items[random_index]
      @items[random_index] = @items[@current]
      @items[@current] = nil
      @current -= 1

      item_to_dequeue
    end
  end

  def sample
    random_index = rand(@current)

    @items[random_index]
  end

  def resize(length)
    copy = Array.new(length)

    length.times do |i|
      copy[i] = @items[i]
    end

    @items = copy
  end

  def iterator
    @iterator ||= RandomIterator.new(@current, @items)
  end
end
