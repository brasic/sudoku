require 'spec_helper'

describe Sudoku::CellGroup do
  let(:complete_valid_row)     { '917654328'  }
  let(:incomplete_valid_row)   { '987.5432.' }
  let(:complete_invalid_row)   { '998817763' }
  let(:incomplete_invalid_row) { '9988.776.' }
  let(:subject) { Sudoku::RowBuilder::SingleRowBuilder.build_one(row) }

  describe '#complete?' do
    context 'with all cells filled' do
      let(:row) { complete_valid_row }
      it{ should be_complete }
    end
    context 'with unfilled cells' do
      let(:row) { incomplete_valid_row }
      it{ should_not be_complete }
    end
    context 'with an invalid but filled row' do
      let(:row) { complete_invalid_row }
      it{ should_not be_complete }
    end
  end

  describe '#valid?' do
    context 'with all cells filled' do
      let(:row) { complete_valid_row }
      it{ should be_valid }
    end
    context 'with unfilled cells but no repeats' do
      let(:row) { incomplete_valid_row }
      it{ should be_valid }
    end
    context 'with an invalid but filled row' do
      let(:row) { complete_invalid_row }
      it{ should_not be_valid }
    end

    context 'with an invalid but unfilled row' do
      let(:row) { incomplete_invalid_row }
      it{ should_not be_valid }
    end
  end
end
