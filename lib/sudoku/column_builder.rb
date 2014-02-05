module Sudoku
  class ColumnBuilder
    attr_reader :rows

    def initialize(rows)
      raise UnexpectedCardinality if rows.size != CARDINALITY
      @rows = rows
    end

    def build_all
      [].tap do |cols|
        0.upto(rows.size-1) do |index|
          cols << column_at_position(index)
        end
      end
    end

    def column_at_position(index)
      Column.new( rows.map { |r| r[index] } )
    end
  end
end
