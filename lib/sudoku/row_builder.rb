module Sudoku
  class RowBuilder
    attr_reader :row_strings

    def initialize(row_strings)
      raise UnexpectedCardinality if row_strings.size != CARDINALITY
      @row_strings = row_strings
    end

    def build_all
      row_strings.map { |row_string| SingleRowBuilder.build_one(row_string) }
    end

    class SingleRowBuilder
      def self.build_one(row)
        raise UnexpectedCardinality if row.size != CARDINALITY
        cells = row.chars.map{ |num| Cell.new(num) }
        Row.new(cells)
      end
    end
  end
end
