# frozen_string_literal: true

def look_and_say(n)
  if n == 1
    puts n
    return [n]
  end

  count = 1
  current_seq = []
  prev_seq = look_and_say(n - 1)
  prev_seq.each_with_index do |num, index|
    if index + 1 < prev_seq.length && prev_seq[index + 1] == num
      count += 1
    else
      current_seq << count
      current_seq << num
      count = 1
    end
  end
  puts current_seq.join(' ')
  current_seq
end

look_and_say(10)
# =>
# 1
# 1 1
# 2 1
# 1 2 1 1
# 1 1 1 2 2 1
# 3 1 2 2 1 1
# 1 3 1 1 2 2 2 1
# 1 1 1 3 2 1 3 2 1 1
# 3 1 1 3 1 2 1 1 1 3 1 2 2 1
# 1 3 2 1 1 3 1 1 1 2 3 1 1 3 1 1 2 2 1 1
