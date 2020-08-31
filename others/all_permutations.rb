# frozen_string_literal: true

# all permutations of a string with unique characters
def perms_uniq(str, prefix = '')
  return [prefix] if str.empty?

  arr = []
  0.upto(str.length - 1) do |index|
    char = str[index]
    arr += perms_uniq(str[0...index] + str[index + 1..-1], prefix + char)
  end
  arr
end

p perms_uniq('') # => [""]
p perms_uniq('a') # => ["a"]
p perms_uniq('ab') # => ["ab", "ba"]
p perms_uniq('abc') # => ["abc", "acb", "bac", "bca", "cab", "cba"]
p perms_uniq('abb') # => ["abb", "abb", "bab", "bba", "bab", "bba"] BAD!

# all permutations of a string with duplicate characters
def perms_dup(str)
  char_freq = Hash.new(0)
  str.each_char do |char|
    char_freq[char] += 1
  end

  perms(char_freq, str.length, '')
end

def perms(char_freq, str_len, prefix)
  return [prefix] if str_len.zero?

  arr = []
  char_freq.each do |char, freq|
    next if freq.zero?

    char_freq[char] -= 1
    arr += perms(char_freq, str_len - 1, prefix + char)
    char_freq[char] = freq
  end
  arr
end

p perms_dup('') # => [""]
p perms_dup('a') # => ["a"]
p perms_dup('ab') # => ["ab", "ba"]
p perms_dup('abc') # => ["abc", "acb", "bac", "bca", "cab", "cba"]
p perms_dup('abb') # => ["abb", "bab", "bba"]
