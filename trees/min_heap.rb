# frozen_string_literal: true

require_relative './binary_tree'

# Class for a min heap, which is a complete binary tree where every node is smaller than its children
class MinHeap
  def initialize
    @arr = []
  end

  def add_node(value)
    @arr << value
    bubble_up(@arr.length - 1)
  end

  def remove_node
    @arr.shift # removal is always from the top
    return unless @arr.length > 1

    @arr.unshift @arr.pop # move last node to the top
    bubble_down(0)
  end

  def height
    Math.log2(size + 1).ceil
  end

  def size
    @arr.length
  end

  def to_s
    @arr.to_s
  end

  private

  def bubble_up(index)
    parent_index = parent(index)
    return unless parent_index >= 0 && @arr[index] < @arr[parent_index]

    @arr[parent_index], @arr[index] = @arr[index], @arr[parent_index]
    bubble_up(parent_index)
  end

  def bubble_down(index)
    # exchange with smaller child
    left_child_index = left_child(index)
    return if left_child_index > @arr.length - 1

    min_child_index = left_child_index
    right_child_index = left_child_index + 1
    if right_child_index <= @arr.length - 1 && @arr[right_child_index] < @arr[left_child_index]
      min_child_index = right_child_index
    end
    return if @arr[index] <= @arr[min_child_index]

    @arr[index], @arr[min_child_index] = @arr[min_child_index], @arr[index]
    bubble_down(min_child_index)
  end

  def parent(index)
    (index - 1) / 2
  end

  def left_child(index)
    2 * index + 1
  end

  def right_child(index)
    2 * index + 2
  end
end

tree = MinHeap.new
[1, 5, 3, 6, 23, 54, 0, 2, 4].each { |value| tree.add_node(value) }
# tree looks like this
#        0
#       /  \
#     2      1
#    / \    / \
#   4  23  54  3
#  / \
# 6   5
puts tree.to_s # => [0, 2, 1, 4, 23, 54, 3, 6, 5]
p tree.height # => 4
p tree.size # => 9

puts '-------------'
tree.remove_node
# tree now looks like this
#        1
#       /  \
#     2      3
#    / \    / \
#   4  23  54  5
#  /
# 6
puts tree.to_s # => [1, 2, 3, 4, 23, 54, 5, 6]
p tree.height # => 4
p tree.size # => 8

puts '-------------'
tree.remove_node
# tree now looks like this
#        2
#       /  \
#     4      3
#    / \    / \
#   6  23  54  5
puts tree.to_s # => [2, 4, 3, 6, 23, 54, 5]
p tree.height # => 3
p tree.size # => 7
