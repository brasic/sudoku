require 'spec_helper'

describe Sudoku::Board do
  let(:subject){ Sudoku::BoardLoader.new(board_string).load }

  context 'with an empty valid board' do
    let(:board_string){ fetch_fixture :empty_valid }
    it{ should be_valid }
    it{ should_not be_complete }
  end

  context 'with an invalid incomplete board' do
    let(:board_string){ fetch_fixture :invalid_incomplete_1 }
    it{ should_not be_valid }
    it{ should_not be_complete }
  end

  context 'with an invalid complete board' do
    let(:board_string){ fetch_fixture :invalid_complete_1 }
    it{ should_not be_valid }
    it{ should_not be_complete }
  end

  context 'with a valid incomplete board' do
    let(:board_string){ fetch_fixture :valid_incomplete_1 }
    it{ should be_valid }
    it{ should_not be_complete }
  end

  context 'with a valid finished board' do
    let(:board_string){ fetch_fixture :valid_complete_1 }
    it{ should be_valid }
    it{ should be_complete }

    it "is mutable and can be unfinished by changing cells" do
      expect(&erasing_top_left_column)
        .to change(&is_complete?)
        .from(true)
        .to(false)
    end
  end

  def erasing_top_left_column
    -> { subject.regions[0][0].erase }
  end

  def is_complete?
    -> { subject.complete? }
  end

end
