# frozen_string_literal: true

class LookAndSay
  def look_and_say(n)
    @sequences = []
    1.upto(n) do |index|
      @sequences[index] = sequence(index) # memoize
      puts @sequences[index].join(' ')
    end
  end

  def sequence(n)
    return [1] if n == 1

    count = 1
    current_seq = []
    prev_seq = @sequences[n - 1] || sequence(n - 1)
    prev_seq.each_with_index do |num, index|
      if index + 1 < prev_seq.length && prev_seq[index + 1] == num
        count += 1
      else
        current_seq << count
        current_seq << num
        count = 1
      end
    end
    current_seq
  end
end

LookAndSay.new.look_and_say(10)
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
