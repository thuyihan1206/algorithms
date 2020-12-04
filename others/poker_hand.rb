# frozen_string_literal: true

class Hand
  FACE_ORDER = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def one_suit?
    @one_suit ||= cards.map { |card| card[:suit] }.uniq.length == 1
  end

  def consecutive?
    return @consecutive if @consecutive

    sorted_faces = cards.map { |card| FACE_ORDER.index(card[:face]) }.sort
    @consecutive = if sorted_faces == [0, 1, 2, 3, 12]
                     true
                   else
                     sorted_faces.each_cons(2).all? { |face1, face2| face2 - face1 == 1 }
                   end
    @consecutive
  end

  def pattern
    return @pattern if @pattern

    groups = cards.group_by { |card| card[:face] }.values
    @pattern = groups.map(&:length).sort
  end

  def highest_hand
    if one_suit? && consecutive?
      'straight-flush'
    elsif pattern == [1, 4]
      'four-of-a kind'
    elsif pattern == [2, 3]
      'full-house'
    elsif one_suit?
      'flush'
    elsif consecutive?
      'straight'
    elsif pattern == [1, 1, 3]
      'three-of-a-kind'
    elsif pattern == [1, 2, 2]
      'two-pair'
    elsif pattern == [1, 1, 1, 2]
      'one-pair'
    else
      'high-card'
    end
  end
end

puts Hand.new(
  [
    { face: '6', suit: 'S' },
    { face: '8', suit: 'S' },
    { face: '10', suit: 'S' },
    { face: '7', suit: 'S' },
    { face: '9', suit: 'S' }
  ]
).highest_hand # => 'straight-flush'

puts Hand.new(
  [
    { face: '6', suit: 'S' },
    { face: 'J', suit: 'D' },
    { face: 'J', suit: 'H' },
    { face: 'J', suit: 'C' },
    { face: 'J', suit: 'S' }
  ]
).highest_hand # => 'four-of-a-kind'

puts Hand.new(
  [
    { face: '5', suit: 'S' },
    { face: 'J', suit: 'D' },
    { face: '5', suit: 'H' },
    { face: 'J', suit: 'C' },
    { face: 'J', suit: 'S' }
  ]
).highest_hand # => 'full-house'

puts Hand.new(
  [
    { face: '6', suit: 'S' },
    { face: 'J', suit: 'S' },
    { face: 'Q', suit: 'S' },
    { face: '2', suit: 'S' },
    { face: '3', suit: 'S' }
  ]
).highest_hand # => 'flush'

puts Hand.new(
  [
    { face: '3', suit: 'S' },
    { face: 'A', suit: 'D' },
    { face: '2', suit: 'H' },
    { face: '5', suit: 'D' },
    { face: '4', suit: 'S' }
  ]
).highest_hand # => 'straight'

puts Hand.new(
  [
    { face: 'J', suit: 'S' },
    { face: 'J', suit: 'D' },
    { face: 'J', suit: 'H' },
    { face: '2', suit: 'D' },
    { face: '3', suit: 'S' }
  ]
).highest_hand # => 'three-of-a-kind'

puts Hand.new(
  [
    { face: '6', suit: 'S' },
    { face: 'J', suit: 'D' },
    { face: 'J', suit: 'H' },
    { face: '6', suit: 'D' },
    { face: '3', suit: 'S' }
  ]
).highest_hand # => 'two-pair'

puts Hand.new(
  [
    { face: '6', suit: 'S' },
    { face: 'J', suit: 'D' },
    { face: 'J', suit: 'H' },
    { face: '2', suit: 'D' },
    { face: '3', suit: 'S' }
  ]
).highest_hand # => 'one-pair'

puts Hand.new(
  [
    { face: '6', suit: 'S' },
    { face: 'J', suit: 'D' },
    { face: 'Q', suit: 'H' },
    { face: '2', suit: 'D' },
    { face: '3', suit: 'S' }
  ]
).highest_hand # => 'high-card'
