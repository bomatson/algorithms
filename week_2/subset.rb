require_relative 'randomized_queue'

class Subset
  def initialize(k, input)
    k = k.to_i
    queue = RandomizedQueue.new
    array = input.split(' ')

    array.each do |item|
      queue.enqueue(item)
    end

    k.times do
      puts queue.dequeue
    end
  end
end

input = $stdin.read
Subset.new(ARGV.first, input)
