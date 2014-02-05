require 'spec_helper'

describe Sudoku::BoardLoader do
  let(:subject){ described_class.new(board_string) }

  describe '#sanitized' do
    context 'with a valid board' do
      let(:board_string){ fetch_fixture :valid_incomplete_1 }
      it 'normalizes a well-formed board' do
        subject.sanitized.size.should  == standard_size
      end
    end
  end

  describe '#load' do
    let(:board) { subject.load }
    context 'with a valid board' do
      let(:board_string){ fetch_fixture :valid_incomplete_1 }

      it 'loads a valid board' do
        expect{ board }.not_to raise_error
      end

      it 'loads cells by reference' do
        first_row = board.rows.first
        first_region = board.regions.first
        first_column = board.columns.first
        first_row.cells[0].object_id == first_column.cells[0].object_id
        first_row.cells[0].object_id == first_region.cells[0].object_id
      end
    end

    context 'with a board that is semantically invalid' do
      let(:board_string){ fetch_fixture :invalid_incomplete_1 }
      it 'loads the board as invalid' do
        expect{ board }.not_to raise_error
        board.should_not be_valid
      end
    end
    context 'with boards that is structurally invalid' do
      context 'variant one -- too many rows' do
        let(:board_string){ fetch_fixture :invalid_extra_rows }
        it 'refuses to load the board' do
          expect{ board }.to raise_error Sudoku::BoardLoader::InvalidBoardFile
        end
      end
      context 'variant two -- too many columns' do
        let(:board_string){ fetch_fixture :invalid_extra_cols }
        it 'refuses to load the board' do
          expect{ board }.to raise_error Sudoku::BoardLoader::InvalidBoardFile
        end
      end
      context 'variant three -- a file that has nothing to do with sudoku' do
        let(:board_string){ File.read(__FILE__) }
        it 'refuses to load the board' do
          expect{ board }.to raise_error Sudoku::BoardLoader::InvalidBoardFile
        end
      end
    end
  end
end

def standard_size
  board_cardinality = 9
  cell_count = board_cardinality ** 2
  newline_count = board_cardinality
  cell_count + newline_count
end

