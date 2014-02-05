module Sudoku
  class Board
    attr_reader :rows, :regions, :columns

    def initialize(row_string, builders)
      @rows = builders.fetch(:row).new(row_string).build_all
      @regions = builders.fetch(:region).new(@rows).build_all
      @columns = builders.fetch(:column).new(@rows).build_all
    end

    def complete?
      ask_all_components(:complete?)
    end

    def valid?
      ask_all_components(:valid?)
    end

    def ask_all_components(message)
      components.all? do |component|
        component.all?(&message)
      end
    end

    def components
      [rows, regions, columns]
    end
  end
end
