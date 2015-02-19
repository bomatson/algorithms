require 'byebug'

class MergeSort
  def bottom_up_merge_sort(a)
    sz = 1
    n = a.count
    while sz < n
      lo = 0

      # Ensure there are at least sz numbers to sort
      while lo < (n - sz)

        # a[lo..hi] has at most 2*sz numbers or
        # at least n-1-lo numbers
        hi = [n-1, lo+sz+sz-1].min

        # a[lo..mid] has sz numbers
        mid = lo+sz-1

        merge_it(a, lo, mid, hi)

        p a.inspect

        lo = hi + 1
      end

      # Ensure that sz is a power of 2
      sz = sz + sz
    end
    a
  end

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

    result.concat(left).concat(right)
  end

  def merge_it(a, lo, mid, hi)
    # a[lo..mid] and a[mid+1..hi] must be sorted
    dup = a.clone

    # index for the left sub-array: lo <= i <= mid
    i = lo

    # index for the right sub-array: mid+1 <= j <= hi
    j = mid+1

    # index for the sorted sub-array: lo <= k <= hi
    k = lo

    while k <= hi
      # All numbers in left sub-array have been compared
      # so copy number from the right sub-array.
      if i > mid
        a[k] = dup[j]
        j += 1

      # All numbers in right sub-array have been compared
      # so copy number from the left sub-array
      elsif j > hi
        a[k] = dup[i]
        i += 1

      # Number in right sub-array is less than the number in
      # left sub-array. So copy number from the right sub-array
      elsif dup[j] < dup[i]
        a[k] = dup[j]
        j += 1

      # Number in left sub-array is less than the number in
      # right sub-array. So copy number from left sub-array
      else
        a[k] = dup[i]
        i += 1
      end
      k += 1
    end

    # The array `a[lo..hi]` is sorted.
  end

  private

  def less(a, alt)
    (a <=> alt) < 0
  end
end
