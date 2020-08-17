# frozen_string_literal: true

# depth first search
# note: we check if a vertex has been visited after popping
def dfs(adj_matrix, source_vertex, target_vertex)
  stack = [source_vertex]
  visited = [] # used to keep track of visited order
  discovered = Array.new(adj_matrix.length, false)
  loop do
    current_vertex = stack.pop
    return false, visited if current_vertex.nil?

    next if discovered[current_vertex]

    discovered[current_vertex] = true
    visited << current_vertex
    return true, visited if current_vertex == target_vertex

    (0...adj_matrix.length).to_a.each do |other_vertex|
      next if adj_matrix[current_vertex][other_vertex].zero?

      stack << other_vertex
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

result, visited_order = dfs(directed_adj_matrix, 0, 3)
puts "#{result ? 'Found it' : 'Did not find it'}: visited order was: #{visited_order.join(', ')}."
# => Found it: visited order was 0, 4, 2, 3.
_result, visited_order = dfs(directed_adj_matrix, 0, 100)
puts "Traversal order was: #{visited_order.join(', ')}."
# => Traversal order was: 0, 4, 2, 3, 5.

puts '-------------'
non_directed_adj_matrix = [
  [0, 0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0, 1],
  [1, 1, 0, 1, 0, 0],
  [0, 0, 1, 0, 1, 1],
  [1, 0, 0, 1, 0, 0],
  [0, 1, 0, 1, 0, 0]
] # and cyclic

result, visited_order = dfs(non_directed_adj_matrix, 0, 3)
puts "#{result ? 'Found it' : 'Did not find it'}: visited order was: #{visited_order.join(', ')}."
# => Found it: visited order was 0, 4, 3.
_result, visited_order = dfs(non_directed_adj_matrix, 0, 100)
puts "Traversal order was: #{visited_order.join(', ')}."
# => Traversal order was: 0, 4, 3, 5, 1, 2.
