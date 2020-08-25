# frozen_string_literal: true

# Class for a list node
class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
  end
end
