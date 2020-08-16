# frozen_string_literal: true

# Colorful Number: When in a given number, product of every digit of a sub-sequence are different.
def colorful?(number)
  set = power_set(digits(number))
  hash = {}
  set.each do |element|
    next if element.empty? # ignore empty set

    product = element.reduce(:*)
    return false if hash[product] # return false if it's already in the hash

    hash[product] = true # add product to hash
  end
  true
end

# returns an array of digit representation
def digits(number)
  raise 'number must be an integer' unless number.is_a?(Integer)
  return [number] if number < 10

  digits(number / 10) + [number % 10]
end

# creates a power set of an array of elements
# for example, a power set of ['a', 'b', c'] is [[], ['a'], ['b'], ['c'], ['a', 'b'], ['b', 'c'], ['a', 'c'], ['a', 'b', 'c']]
def power_set(array)
  raise 'array must be an array' unless array.is_a?(Array)

  combination(array, Array.new(array.length), array.length - 1)
end

def combination(array, binary, index)
  # binary is an array of boolean that indicates if a specific element in the array should be selected
  if index.zero?
    binary[index] = false
    set_element1 = build_set_element(array, binary)
    binary[index] = true
    set_element2 = build_set_element(array, binary)
    return [set_element1] + [set_element2]
  end
  binary[index] = false
  set1 = combination(array, binary, index - 1)
  binary[index] = true
  set2 = combination(array, binary, index - 1)
  set1 + set2
end

def build_set_element(array, binary)
  array.select.with_index { |_, index| binary[index] }
end

# p power_set(['a', 'b', 'c'])
p colorful? 326 # => false
p colorful? 3245 # => true
