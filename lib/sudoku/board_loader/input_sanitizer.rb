module Sudoku
  class BoardLoader
    class InputSanitizer
      LEGAL_CHARS = /[^\n1-9\.]/

      def initialize(str)
        @str = str
      end

      def cleaned
        without_bad_chars
        without_extra_newlines
      end

      def without_bad_chars
        @str.gsub!(LEGAL_CHARS,'')
      end

      def without_extra_newlines
        @str.gsub!("\n\n","\n")
      end
    end
  end
end
