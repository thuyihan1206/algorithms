# frozen_string_literal: true

require_relative './node'

# Class for a binary tree
class BinaryTree
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

    output[level] ||= []
    output[level] << local_root.value
    level_traverse(local_root.left, level + 1, output)
    level_traverse(local_root.right, level + 1, output)
    output
  end
end
