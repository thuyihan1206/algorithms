# frozen_string_literal: true

# Class for a tree node
class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end
end

# Class for a Binary Search Tree
class Tree
  attr_accessor :root

  def add_node(value, local_root = @root)
    if local_root.nil?
      local_root = Node.new(value)
      @root = local_root if @root.nil? # set root for the tree
    else
      case value <=> local_root.value
      when 0
        raise 'duplicate value is not allowed'
      when -1
        local_root.left = add_node(value, local_root.left)
      when 1
        local_root.right = add_node(value, local_root.right)
      end
    end
    local_root
  end

  def remove_node(value, local_root = @root)
    return nil if local_root.nil?

    case value <=> local_root.value
    when 0
      local_root = remove(local_root)
    when -1
      local_root.left = remove_node(value, local_root.left)
    when 1
      local_root.right = remove_node(value, local_root.right)
    end
    local_root
  end

  def search(value, local_root = @root)
    return false if local_root.nil?

    case value <=> local_root.value
    when 0
      true
    when -1
      search(value, local_root.left)
    when 1
      search(value, local_root.right)
    end
  end

  def inorder_traverse(local_root = @root)
    return [] if local_root.nil?

    inorder_traverse(local_root.left) + [local_root.value] + inorder_traverse(local_root.right)
  end

  def height(local_root = @root)
    return 0 if local_root.nil?

    1 + [height(local_root.left), height(local_root.right)].max
  end

  def size(local_root = @root)
    return 0 if local_root.nil?

    1 + size(local_root.left) + size(local_root.right)
  end

  def to_s
    level_traverse.reduce('') do |str, element|
      str + "#{element}\n"
    end
  end

  private

  def level_traverse(local_root = @root, level = 0, output = [])
    return [] if local_root.nil?

    output << [] if output.length == level # add a new array for the next level
    output[level] << local_root.value
    level_traverse(local_root.left, level + 1, output)
    level_traverse(local_root.right, level + 1, output)
    output
  end

  def remove(node)
    return node.left if node.right.nil? # node.left is okay to be nil
    return node.right if node.left.nil?

    # when node has 2 children, replace with largest item in the left tree (inorder predecessor)
    if node.left.right.nil?
      node.value = node.left.value
      node.left = node.left.left
    else
      node.value = largest_child(node.left)
    end
    node
  end

  def largest_child(node)
    return largest_child(node.right) if node.right.right

    value = node.right.value
    node.right = node.right.left
    value
  end
end

tree = Tree.new
[1, 5, 3, 6, 23, 54, 0, 2, 4].each { |value| tree.add_node(value) }
# tree looks like this
#      1
#     / \
#    0   5
#       / \
#      3   6
#     / \   \
#    2   4   23
#              \
#               54
puts tree.to_s
p tree.search(1) # => true
p tree.search(5) # => true
p tree.search(6) # => true
p tree.height # => 5
p tree.size # => 9
p tree.inorder_traverse # => [0, 1, 2, 3, 4, 5, 6 23, 54]

puts '-------------'
tree.remove_node(1)
# tree now looks like this
#      0
#       \
#        5
#       / \
#      3   6
#     / \   \
#    2   4   23
#              \
#               54
puts tree.to_s
p tree.search(1) # => false
p tree.height # => 5
p tree.size # => 8
p tree.inorder_traverse # => [0, 2, 3, 4, 5, 6 23, 54]

puts '-------------'
tree.remove_node(5)
# tree now looks like this
#      0
#       \
#        4
#       / \
#      3   6
#     /     \
#    2       23
#              \
#               54
puts tree.to_s
p tree.search(5) # => false
p tree.height # => 5
p tree.size # => 7
p tree.inorder_traverse # => [0, 2, 3, 4, 6 23, 54]

puts '-------------'
tree.remove_node(6)
# tree now looks like this
#      0
#       \
#        4
#       / \
#      3   23
#     /      \
#    2        54
puts tree.to_s
p tree.search(6) # => false
p tree.height # => 4
p tree.size # => 6
p tree.inorder_traverse # => [0, 2, 3, 4, 23, 54]
