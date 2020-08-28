# frozen_string_literal: true

# given a string S and a string T, find the minimum window in S which will contain all the characters in T
def min_window(s, t)
  return nil if s.length < t.length

  # create hash for string T
  t_hash = {}
  t.each_char do |c|
    t_hash[c] ||= 0
    t_hash[c] += 1
  end

  filtered_s = [] # record chars and indexes that are present in T from S
  s.each_char.with_index do |char, index|
    next unless t_hash[char]

    filtered_s << [char, index]
  end

  left_start = nil
  count = 0
  min_window = nil

  filtered_s.each do |(c, right_index)|
    next unless t_hash[c]

    left_start ||= right_index
    count += 1 if t_hash[c] == 1
    t_hash[c] -= 1

    next unless count == t_hash.length

    while count == t_hash.length
      if t_hash[s[left_start]]
        t_hash[s[left_start]] += 1
        count -= 1 if t_hash[s[left_start]] == 1
      end
      left_start += 1
    end
    left_index = left_start - 1 # back one to include the valid character
    min_window = s[left_index..right_index] if min_window.nil? || right_index - left_index + 1 < min_window.length
  end
  min_window
end

p min_window('dcbefebce', 'fd') # => "dcbef"
p min_window('dcdefebce', 'fd') # => "def"
p min_window('dcbefebdf', 'fd') # => "df"
p min_window('ecbefebce', 'fd') # => nil
p min_window('dcbefedce', 'fdd') # => "dcbefed"
p min_window('dcbefebce', 'bcdecebfe') # => "dcbefebce"
p min_window('dcbefedce', 'fddfddfddfdd') # => nil
p min_window('cabwefgewcwaefgcf', 'cae') # => 'cwae'
