require 'byebug'
class RandomIterator
  def initialize(current, items)
    @current = current
    @indexes = []
    @items = items

    @current.times do |i|
      @indexes[i] = i
    end

    @indexes.shuffle!
  end

  def next
    @items[@indexes[@current -= 1]]
  end
end
