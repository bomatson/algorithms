require 'byebug'

class MergeSort
  # def sort(aux, lo, high)
  #   return if high <= lo

  #   mid = lo + (high - lo) / 2

  #   sort(aux, lo, mid)
  #   sort(aux, mid + 1, high)

  #   merge(aux, lo, mid, high)
  # end

  # def merge(aux, lo, mid, high)
  #   high.times do |i|
  #     aux[i] = @actual[i]
  #   end

  #   j = mid + 1
  #   i = lo

  #   high.times do |k|
  #     if i > mid
  #       @actual[k] = aux[j]
  #       j += 1
  #     elsif j > high
  #       # this should only need to find j > high
  #       @actual[k] = aux[i]
  #       i += 1
  #     elsif less(aux[j], aux[i])
  #       @actual[k] = aux[j]
  #       j += 1
  #     else
  #       @actual[k] = aux[i]
  #       i += 1
  #     end
  #   end
  # end

  def merge_sort(array)
    return array if array.size <= 1
    left = merge_sort array[0, array.size / 2]
    right = merge_sort array[array.size / 2, array.size]

    merging(left, right)
  end


  def merging(left, right)
    result = []

    while left.size > 0 && right.size > 0
      result << if left[0] <= right[0]
        left.shift
      else
        right.shift
      end
    end

    something = result.concat(left).concat(right)
    p something
  end

  private

  def less(a, alt)
    (a <=> alt) < 0
  end
end
