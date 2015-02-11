class WeightedQuickUnion
  attr_reader :ids, :sz

  def initialize(n)
    @count = n
    @ids = (0..n-1).to_a
    @sz = Array.new(n, 1)
  end

  def root(n)
    while (n != @ids[n]) do
      n = @ids[n];
    end
    n
  end

  def connected?(p, q)
    root(p) == root(q)
  end

  def union(p, q)
    initial = root(p)
    new_entry = root(q)

    return if initial == new_entry

    if @sz[initial] < @sz[new_entry]
      @ids[initial] = new_entry
      @sz[new_entry] += @sz[initial]
    else
      @ids[new_entry] = initial
      @sz[initial] += @sz[new_entry]
    end
    @count -= 1
  end
end

# 5-8 2-4 7-9 7-8 6-0 1-4 0-4 0-3 4-9

# quick = WeightedQuickUnion.new 10
# 
# quick.union(5,8)
# quick.union(2,4)
# quick.union(7,9)
# quick.union(7,8)
# quick.union(6,0)
# quick.union(1,4)
# quick.union(0,4)
# quick.union(0,3)
# quick.union(4,9)
# 
# puts quick.ids.inspect
