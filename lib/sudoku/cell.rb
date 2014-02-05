module Sudoku
  class Cell
    attr_reader :val
    Empty = Class.new

    def initialize(item)
      @val = case item
             when '.' then Empty
             else item.to_i
             end
    end

    def erase
      @val = Empty
    end

    def empty?
      val == Empty
    end

    def filled?
      !empty?
    end
  end
end
