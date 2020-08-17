# frozen_string_literal: true

# breadth first search
# note: we check if a vertex has been discovered before enqueueing
def bfs(adj_matrix, source_vertex, target_vertex)
  queue = [source_vertex]
  visited = [] # used to keep track of visited order
  discovered = Array.new(adj_matrix.length, false)
  discovered[source_vertex] = true
  loop do
    current_vertex = queue.shift
    return false, visited if current_vertex.nil?

    visited << current_vertex
    return true, visited if current_vertex == target_vertex

    (0...adj_matrix.length).to_a.each do |other_vertex|
      next if discovered[other_vertex] || adj_matrix[current_vertex][other_vertex].zero?

      queue << other_vertex
      discovered[other_vertex] = true
    end
  end
end

directed_adj_matrix = [
  [0, 0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0, 1],
  [0, 0, 0, 1, 0, 0],
  [0, 0, 0, 0, 1, 1],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0]
] # and acyclic

result, visited_order = bfs(directed_adj_matrix, 0, 3)
puts "#{result ? 'Found it' : 'Did not find it'}: visited order was: #{visited_order.join(', ')}."
# => Found it: visited order was 0, 2, 4, 3.
_result, visited_order = bfs(directed_adj_matrix, 0, 100)
puts "Traversal order was: #{visited_order.join(', ')}."
# => Traversal order was: 0, 2, 4, 3, 5.

puts '-------------'
non_directed_adj_matrix = [
  [0, 0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0, 1],
  [1, 1, 0, 1, 0, 0],
  [0, 0, 1, 0, 1, 1],
  [1, 0, 0, 1, 0, 0],
  [0, 1, 0, 1, 0, 0]
] # and cyclic

result, visited_order = bfs(non_directed_adj_matrix, 0, 3)
puts "#{result ? 'Found it' : 'Did not find it'}: visited order was: #{visited_order.join(', ')}."
# => Found it: visited order was 0, 2, 4, 1, 3.
_result, visited_order = bfs(non_directed_adj_matrix, 0, 100)
puts "Traversal order was: #{visited_order.join(', ')}."
# => Traversal order was: 0, 2, 4, 1, 3, 5.
