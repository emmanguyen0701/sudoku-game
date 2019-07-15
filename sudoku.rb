require_relative 'board'

class Game

    def self.from_file(textFile)
        board = Board.from_file(textFile)
        self.new(board)
    end

    def initialize(board)
        @board = board
    end

    def run
        play until board.solved?
        boad.render
        puts "You win!!!"
    end

    def play      
        board.render
        pos = get_pos
        val = get_val
        board[pos] = val
    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "Enter a position on the board (e.g 3,2)"
            print "> "
            pos = parse_pos(gets.chomp)
        end
        pos
    end

    def get_val
        val = nil
        until val && valid_val?(val)
            puts "Enter a value between 1 and 9"
            print "> "
            val = parse_val(gets.chomp)
        end
        val
    end

    def parse_pos(pos)
        pos.split(",").map{ |el| Integer(el) }
    end

    def valid_pos?(pos)
        pos.is_a?(Array) &&
        pos.all? { |el| el.between?(0,8) }
    end

    def parse_val(val)
        Integer(val)
    end

    def valid_val?(val)
        val.is_a?(Integer) &&
        val.between?(1,9)
    end

    private

    attr_reader :board
end

game = Game.from_file("./puzzles/sudoku1.txt")
game.run