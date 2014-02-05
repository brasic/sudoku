module Sudoku
  class CellGroup
    extend Forwardable
    extend Enumerable
    attr_reader :cells
    def_delegators :cells, :each, :[], :<<, :map

    def initialize(cells)
      @cells = cells
    end

    def front()  @cells[0..2] end
    def middle() @cells[3..5] end
    def back()   @cells[6..8] end

    def complete?
      valid? && unfilled_cells.empty?
    end

    def sorted
      cells.map(&:val).sort
    end

    def filled_cells
      cells.select(&:filled?)
    end

    def unfilled_cells
      cells.select(&:empty?)
    end

    def valid?
      filled_cells == filled_cells.uniq(&:val)
    end
  end

  class Column < CellGroup; end
  class Row < CellGroup; end
  class Region < CellGroup; end
end
