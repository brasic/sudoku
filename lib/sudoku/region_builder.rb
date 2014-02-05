module Sudoku
  # A Region's position on the board is numbered like:
  # 012
  # 345
  # 678
  # Cells within Regions are numbered in the same way.
  class RegionBuilder
    attr_reader :rows
    def initialize(rows)
      raise UnexpectedCardinality if rows.size != CARDINALITY
      @rows = rows
    end

    def build_all
      [].tap do |regions|
        0.upto(rows.size-1) do |index|
          regions << region_at_position(index)
        end
      end
    end

    def region_at_position(region_number)
      extract_cells = ->(row) { row.send(row_segment_for(region_number)) }
      cells = rows_involved_in(region_number)
                .map(&extract_cells).flatten
      Region.new(cells)
    end

    def row_segment_for(region_number)
      case region_number
      when 0,3,6 then :front
      when 1,4,7 then :middle
      when 2,5,8 then :back
      end
    end

    def rows_involved_in(region_number)
      rows.slice( case region_number
                  when (0..2) then (0..2)
                  when (3..5) then (3..5)
                  when (6..8) then (6..8)
                  end )
    end

  end
end
