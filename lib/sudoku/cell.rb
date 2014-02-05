module Sudoku
  class Cell
    attr_accessor :val
    Empty = Class.new

    def initialize(val)
      @val = (val == '.') ? Empty : val.to_i
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

