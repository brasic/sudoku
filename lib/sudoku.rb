module Sudoku
  CARDINALITY = 9
  class UnexpectedCardinality < StandardError; end
end

require_relative 'sudoku/cell'
require_relative 'sudoku/cell_group'
require_relative 'sudoku/column_builder'
require_relative 'sudoku/row_builder'
require_relative 'sudoku/region_builder'
require_relative 'sudoku/board'
require_relative 'sudoku/board_loader'
