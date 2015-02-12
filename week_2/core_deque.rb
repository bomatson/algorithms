require_relative 'iterator'

class CoreDeque
  attr_reader :head, :tail, :node_count

  Node = Struct.new(:item, :prev, :next)

  def initialize
    @head = nil
    @tail = nil
    @node_count = 0
  end

  def add_first(item)
    if @head
      @head.prev = Node.new(item, nil, @head)
      @head = @head.prev
    else
      @head = @tail = Node.new(item)
    end

    @node_count += 1
  end

  def add_last(item)
    if @tail
      @tail.next = Node.new(item, @tail, nil)
      @tail = @tail.next
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

  def remove_last
    return nil unless @tail

    item = @tail.item
    @tail = @tail.prev

    @node_count -= 1
    item
  end

  def remove_first
    return nil unless @head

    item = @head.item
    @head = @head.next

    @node_count -= 1
    item
  end

  def iterator
    @iterator ||= Iterator.new(@head)
  end
end
