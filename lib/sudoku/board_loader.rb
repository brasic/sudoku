require_relative 'board_loader/input_sanitizer'

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
      InputSanitizer.new(board_string).cleaned
    end

    class InvalidBoardFile < ArgumentError; end
  end
end
