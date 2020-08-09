# frozen_string_literal: true

# breadth first search
# note: we check if a vertex has been visited before enqueueing
def bfs(adj_matrix, source_vertex, target_vertex)
  queue = [source_vertex]
  visited = {} # used to keep track of visited order
  loop do
    current_vertex = queue.shift
    return false, visited.keys if current_vertex.nil?

    visited[current_vertex] = true
    return true, visited.keys if current_vertex == target_vertex

    (0...adj_matrix.length).to_a.each do |other_vertex|
      queue << other_vertex if !visited[other_vertex] && adj_matrix[current_vertex][other_vertex] == 1
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
