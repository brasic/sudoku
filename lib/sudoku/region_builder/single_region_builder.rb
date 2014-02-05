module Sudoku
  class RegionBuilder
    # Build a single region at some position from a row collection.
    class SingleRegionBuilder
      attr_reader :rows, :position

      def initialize(rows, position)
        @rows = rows
        @position = position
      end

      def build
        Region.new(cells)
      end

      def cells
        involved_rows.map(&cell_extractor).flatten
      end

      def cell_extractor
        ->(row) { row.send involved_segment }
      end

      # For the given region number, what is the row segment
      def involved_segment
        case position % 3
        when 0 then :front
        when 1 then :middle
        when 2 then :back
        end
      end

      def involved_rows
        rows.slice case position
                   when (0..2) then (0..2)
                   when (3..5) then (3..5)
                   when (6..8) then (6..8)
                   end
      end
    end
  end
end
