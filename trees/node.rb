# frozen_string_literal: true

# Class for a tree node
class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end
end
