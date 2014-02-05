require_relative 'region_builder/single_region_builder'

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
        1.upto(CARDINALITY) do |position|
          regions << SingleRegionBuilder.new(rows, position-1).build
        end
      end
    end
  end
end
