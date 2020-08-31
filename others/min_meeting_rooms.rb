# frozen_string_literal: true

require_relative '../trees/min_heap'

# given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...],
# find the minimum number of conference rooms required
def min_meeting_rooms(intervals)
  sorted_intervals = intervals.sort { |a, b| a[0] <=> b[0] }
  heap = MinHeap.new

  count = 0
  sorted_intervals.each do |(start, stop)|
    if heap.size.zero?
      heap.add_node(stop)
      count += 1
    else
      if start >= heap.top
        heap.remove_node
      else
        count += 1
      end
      heap.add_node(stop)
    end
  end
  count
end

p min_meeting_rooms([[2, 15], [36, 45], [9, 29], [16, 23], [4, 9]]) # => 2
