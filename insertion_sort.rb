# frozen_string_literal: true

# in-place insertion sort
def sort(arr)
  arr.each_with_index do |element, index|
    next if index.zero?

    # from the buttom of the array, move elements down if they are greater than the current element
    while index.positive? && arr[index - 1] > element
      arr[index] = arr[index - 1]
      index -= 1
    end
    arr[index] = element
  end
  arr
end

arr = [1, 3, 98, 2, 3, 6, 4, 0, 1]
p sort(arr)
