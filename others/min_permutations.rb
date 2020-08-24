# frozen_string_literal: true

# given an integer N (between 1 and 8) and a permutation P of the integers from 1 to N
# compute the minimum number of sub-array reversals required to return the permutation to increasing order
def min_permutations(arr)
  # treat each permutation as a node in a graph
  # use BFS to find target
  target = arr.sort
  queue = [{ perm: arr, count: 0 }]
  discovered = { arr => true }
  loop do
    node = queue.shift
    return -1 if node.empty? # should not be here

    return node[:count] if node[:perm] == target

    0.upto(arr.length - 1) do |i|
      (i + 1).upto(arr.length - 1) do |j|
        other_node = { perm: reverse_array(node[:perm], i, j), count: node[:count] + 1 }
        next if discovered[other_node[:perm]]

        queue << other_node
        discovered[other_node[:perm]] = true
      end
    end
  end
end

def reverse_array(arr, start, stop)
  arr[0...start] + arr[start..stop].reverse + arr[stop + 1..-1]
end

p min_permutations([3, 1, 2]) # => 2
p min_permutations([1, 2, 3, 5, 4]) # => 1
p min_permutations([3, 2, 4, 1]) # => 2
p min_permutations([1]) # => 0
p min_permutations([1, 2, 3, 4, 5, 6, 7, 8]) # => 0
p min_permutations([8, 7, 6, 5, 4, 3, 2, 1]) # => 1
p min_permutations([8, 7, 6, 5, 1, 2, 3, 4]) # => 2
