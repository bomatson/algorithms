class QuickFind
  def initialize
    @core_array = []

    build_array(10)
  end

  def build_array(n)
    n.times do |i|
      @core_array[i] = i
    end

    @core_array
  end

  def connected?(p, q)
    @core_array[p] == @core_array[q]
  end

  def union(p, q)
    initial = @core_array[p]
    new_entry = @core_array[q]

    @core_array = @core_array.map do |i|
      if i == initial
        new_entry
      else
        i
      end
    end
  end
end
