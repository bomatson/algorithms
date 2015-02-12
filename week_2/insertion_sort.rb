require 'byebug'

class InsertionSort
  attr_reader :result

  def initialize(array)
    # make sure to walk through i to N -1
    (1..array.length-1).each do |i|

      # remove the value is being inserted
      value_to_insert = array.delete_at(i)

      insertion_index = i
      insertion_index -= 1 while insertion_index > 0 && value_to_insert < array[insertion_index -1]

      array.insert(insertion_index, value_to_insert)
    end

    @result = array
  end
end
