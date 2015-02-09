require 'byebug'
require_relative 'weighted_quick_union'

class Percolation
  attr_accessor :size, :strategy, :sites

  def initialize(n)
    @row_length = n
    @size = n * n
    @strategy = WeightedQuickUnion.new(@size + 2)
    @sites = Array.new(@row_length) { Array.new(@row_length, 0) }
    @virtual_top = @size
    @virtual_bottom = @size + 1

    @sites.each_with_index do |ary, index|
      @strategy.union(@virtual_top, index)
      @strategy.union(@virtual_bottom, @size - 1 - index)
    end
  end

  def is_open?(row, col)
    @sites[row - 1][col - 1] == 1
  end

  def open(row, col)
    row_index = row - 1
    col_index = col - 1

    unless is_open?(row, col)
      site_id = (row_index * @row_length) + col_index

      neighbors = [[row_index-1, col_index],
                   [row_index+1, col_index],
                   [row_index, col_index-1],
                   [row_index, col_index+1]]

      neighbors.each do |neighbor|
        next if neighbor[0] < 0 || neighbor[0] > @row_length || neighbor[1] < 0 || neighbor[1] > @row_length

        if is_open?(neighbor[0], neighbor[1])
          # why did I need to normalize here?
          neighbor_site_id = ((neighbor[0] - 1) * @row_length) + (neighbor[1] - 1)

          if !@strategy.connected?(site_id, neighbor_site_id)
            @strategy.union(site_id, neighbor_site_id)
          end

          if is_full?(neighbor[0] + 1, neighbor[1] + 1)
            @strategy.union(@virtual_top, site_id)
          end
        end
      end

      @sites[row_index][col_index] = 1
    end
  end

  def is_full?(row, col)
    row_index = row - 1
    col_index = col - 1
    site_id = (row_index * @row_length) + col_index

    is_open?(row, col) && @strategy.connected?(site_id, @virtual_top)
  end

  def percolates?
    @strategy.connected?(@virtual_top, @virtual_bottom)
  end

  def monte_carlo
    @sites.shuffle.each do |site|
      open(site[0], site[1])

      break if percolates?
    end
  end
end
