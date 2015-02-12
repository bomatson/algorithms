require 'byebug'

class Deque
  attr_reader :items

  def initialize
    @items = []
  end

  def is_empty?
    @items.empty?
  end

  def add_first(item)
    @items.unshift(item)
  end

  def add_last(item)
    @items.push(item)
  end

  def size
    @items.size
  end

  def remove_first
    @items.shift
  end

  def remove_last
    @items.pop
  end

  def iterator
    @items.each
  end
end
