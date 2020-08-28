# frozen_string_literal: true

require_relative './node'

# Class for a singly linked list
class SinglyLinkedList
  def create_list(arr)
    node = nil
    until arr.empty?
      value = arr.shift
      next @head = node = Node.new(value) if node.nil?

      node.next = Node.new(value)
      node = node.next
    end
    @head
  end

  def reverse_iterative!(current = @head)
    prev = nil
    while current
      temp = current.next
      current.next = prev
      prev = current
      current = temp
    end
    @head = prev
  end

  def reverse_recursive!(current = @head, prev = nil)
    return @head = prev if current.nil?

    temp = current.next
    current.next = prev
    reverse_recursive!(temp, current)
  end

  def to_s(node = @head)
    arr = []
    while node
      arr << node.value
      node = node.next
    end
    arr
  end
end

list = SinglyLinkedList.new
list.create_list([2, 3, 1, 5, 3])
p list.to_s # => [2, 3, 1, 5, 3]
list.reverse_iterative!
p list.to_s # => [3, 5, 1, 3, 2]
list.reverse_recursive!
p list.to_s # => [2, 3, 1, 5, 3]

list = SinglyLinkedList.new
list.create_list([])
p list.to_s # => []
list.reverse_iterative!
p list.to_s # => []
list.reverse_recursive!
p list.to_s # => []
