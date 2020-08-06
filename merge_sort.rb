# frozen_string_literal: true

# merge sort
def sort(arr)
  return arr if arr.length <= 1

  half = arr.length / 2
  arr_left = arr[0...half]
  arr_right = arr[half...arr.length]
  merge(sort(arr_left), sort(arr_right))
end

def merge(arr1, arr2)
  # arr1 and arr2 are sorted
  arr = []
  arr << (arr1.first <= arr2.first ? arr1.shift : arr2.shift) while !arr1.empty? && !arr2.empty?
  arr + arr1 + arr2
end

arr = [1, 3, 98, 2, 3, 6, 4, 0, 1]
p sort(arr)
