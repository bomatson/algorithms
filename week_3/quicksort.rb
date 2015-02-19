class QuickSort
  def partition(a, low, high)
    i = low + 1
    j = high

    while true
      while less(a[i], a[low])
        i += 1
        if i == high
          break
        end
      end

      while less(a[low], a[j])
        j -= 1
        if j == low
          break
        end
      end

      if i >= j
        break
      end

      swap(a, i, j)
    end

    swap(a, low, j)
    j
  end

  def better_partition(keys, left, right)
    x = keys[right]
    i = left-1
    for j in left..right-1
      if keys[j] <= x
        i += 1
        keys[i], keys[j] = keys[j], keys[i]
      end
    end
    keys[i+1], keys[right] = keys[right], keys[i+1]
    i+1
  end

  private

  def less(a, alt)
    # for duplicate keys, returns true if they are equal
    (a <=> alt) < 0
  end

  def swap(arr, i, j)
    swap = arr[i]
    arr[i] = arr[j]
    arr[j] = swap
  end
end
