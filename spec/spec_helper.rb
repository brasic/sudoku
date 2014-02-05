$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../sudoku')
require 'sudoku'

def fetch_fixture(file_name)
  File.read(File.dirname(__FILE__)+"/fixtures/#{file_name}.txt")
end

