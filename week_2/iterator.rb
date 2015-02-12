class Iterator
  def initialize(target)
    @target = target
  end

  def next
    item = @target.item
    @target = @target.next

    item
  end

  def has_next?
    @target.next != nil
  end
end
