# frozen_string_literal: true

# in-place quicksort
def sort(arr, left = 0, right = arr.length - 1)
  if left < right
    pivot_index = partition(arr, left, right)
    sort(arr, left, pivot_index - 1)
    sort(arr, pivot_index + 1, right)
  end
  arr
end

def partition(arr, left, right)
  pivot = arr[left]
  up = left
  down = right
  loop do
    # pivot is greater than or equal to its left elements and less than its right elements
    up += 1 while up < right && pivot >= arr[up]
    down -= 1 while pivot < arr[down]
    break unless up < down

    arr[down], arr[up] = arr[up], arr[down] # exchange up and down
  end
  arr[down], arr[left] = arr[left], arr[down] # exchange left and down
  down
end

arr = [1, 3, 98, 2, 3, 6, 4, 0, 1]
p sort(arr)
