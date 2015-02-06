require 'byebug'
require_relative 'weighted_quick_union'

class Percolation
  attr_accessor :size, :strategy, :sites

  def initialize(n)
    @row_length = n
    @size = n * n
    @strategy = WeightedQuickUnion.new(@size)
    @sites = Array.new @size, [1,1,false]
    build_grid
  end

  def is_open?(row, col)
    site = @sites.detect { |site| site[0] == row && site[1] == col}

    if site
      site[2]
    end
  end

  def open(row, col)
    unless is_open?(row, col)
      site = @sites.detect { |site| site[0] == row && site[1] == col}
      site[2] = true

      neighbors = [[row-1, col], [row+1, col], [row, col-1], [row, col+1]]

      neighbors.each do |neighbor|
        if is_open?(neighbor[0], neighbor[1])
          @strategy.union(@sites.index(neighbor.push(true)), @sites.index(site))
        end
      end
    end
  end

  def is_full?(row, col)
    return false unless is_open?(row, col)

    top_row_indexes = (0..@row_length - 1).to_a

    top_row_indexes.each do |index|
      return @strategy.connected?(index, @sites.index([row, col, true]))
    end

    false
  end

  def percolates?
    bottom_row = @sites.last(@row_length)

    bottom_row.each do |site|
      return is_full?(site[0], site[1])
    end
  end

  def monte_carlo
    @sites.shuffle.each do |site|
      open(site[0], site[1])

      break if percolates?
    end

    @sites.select{ |site| site[2] == true }.count.to_f / @size
  end

  private

  def build_grid
    col_interval = 1
    row_interval = 1

    @sites.map! do |site|
      position = [row_interval, col_interval, false]
      col_interval += 1

      if col_interval > @row_length
        col_interval = 1
        row_interval += 1
      end

      position
    end
  end
end
