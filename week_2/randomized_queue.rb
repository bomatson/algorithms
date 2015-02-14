class RandomizedQueue
  attr_reader :items, :tail

  def initialize
    @items = []
    @tail = 0
  end

  def size
    @tail
  end

  def enqueue(item)
    @items[@tail] = item
    @tail += 1
  end

  def dequeue
    if @tail > 0
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
end
