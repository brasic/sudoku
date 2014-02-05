module Sudoku
  BUILDERS = {
    row: RowBuilder,
    column: ColumnBuilder,
    region: RegionBuilder
  }

  class BoardLoader
    attr_reader :board_string

    def initialize(board_string)
      @board_string = board_string
    end

    def load
      Board.new(row_strings, BUILDERS)
    rescue UnexpectedCardinality
      raise InvalidBoardFile
    end

    def row_strings
      sanitized.split("\n").reject(&:empty?)
    end

    def sanitized
      board_string.gsub(/[^\n1-9\.]/,'').gsub("\n\n","\n")
    end

    class InvalidBoardFile < ArgumentError; end
  end
end
