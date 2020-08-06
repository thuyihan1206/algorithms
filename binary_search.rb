# frozen_string_literal: true

# binary search on a sorted array - returns index
def search_index(arr, target, left = 0, right = arr.length - 1)
  return -1 if left > right # -1 means no found

  half = (left + right) / 2
  return half if arr[half] == target

  if target < arr[half]
    search_index(arr, target, left, half - 1)
  else
    search_index(arr, target, half + 1, right)
  end
end

# binary search on a sorted array - returns true/false
def search_bool(arr, target)
  return false if arr.empty?

  half = arr.length / 2
  return true if arr[half] == target

  if target < arr[half]
    search_bool(arr[0...half], target)
  else
    search_bool(arr[(half + 1)...arr.length], target)
  end
end

arr = [0, 1, 2, 3, 4, 6, 98, 124]
p search_index(arr, -3) # => -1
p search_index(arr, 0) # => 0
p search_index(arr, 6) # => 5
p search_index(arr, 15) # => -1
p search_index(arr, 124) # => 7
p search_index(arr, 156) # => -1

p search_bool(arr, -3) # => false
p search_bool(arr, 0) # => true
p search_bool(arr, 6) # => true
p search_bool(arr, 15) # => false
p search_bool(arr, 124) # => true
p search_bool(arr, 156) # => false
