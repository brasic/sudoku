require 'spec_helper'

module Sudoku
  describe RegionBuilder do
    let(:row_strings){ BoardLoader.new(board_string).row_strings }
    let(:rows){ RowBuilder.new(row_strings).build_all }
    let(:subject){ described_class.new(rows).build_all }


    context 'with a board' do
      let(:board_string){%Q{
        8 5 9 |6 1 2 |4 3 7
        7 2 3 |8 5 4 |1 6 9
        1 6 4 |3 7 9 |5 2 8
        ------+------+-----
        9 8 6 |1 4 7 |3 5 2
        3 7 5 |2 6 8 |9 1 4
        2 4 1 |5 9 3 |7 8 6
        ------+------+-----
        4 3 2 |9 8 1 |6 7 5 <
        6 1 7 |4 2 5 |8 9 3 <
        5 9 8 |7 3 6 |2 4 1 <
                      ^^^^^
      }}
      it 'builds regions from rows' do
        subject.last.map(&:val).should == [6,7,5,8,9,3,2,4,1]
      end
    end

    context 'with a broken board' do
      let(:board_string){%Q{
       8 8 5 9 |6 1 2 |4 3 7
       7 7 2 3 |8 5 4 |1 6 9
       1 1 6 4 |3 7 9 |5 2 8
       --------+------+-----
       9 9 8 6 |1 4 7 |3 5 2
       3 3 7 5 |2 6 8 |9 1 4
       2 2 4 1 |5 9 3 |7 8 6
       --------+------+-----
       4 4 3 2 |9 8 1 |6 7 5
       6 6 1 7 |4 2 5 |8 9 3
       5 5 9 8 |7 3 6 |2 4 1
       5 5 9 8 |7 3 6 |2 4 1 }}

      it 'raises an error' do
        expect{ subject }.to raise_error(UnexpectedCardinality)
      end
    end

  end
end
