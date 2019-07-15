require_relative 'tile'

class Board
    def self.empty_grid
        Array.new(9) do
            Array.new(9) { Tile.new(0) }
        end
    end 

    def self.from_file(textFile)
        arr = File.readlines(textFile).map(&:chomp)
        num_arr = arr.map do |el|
            sub_arr = el.split("").map{ |el| Integer(el) }
            sub_arr.map do |ele|
                 Tile.new(ele)
            end
        end
        self.new(num_arr)
    end

    def initialize(grid = Board.empty_grid)
        @grid = grid
    end

    def [](pos)
        row, col = pos
        grid[row][col]      
    end

    def []=(pos, val)
        row, col = pos    
        tile = grid[row][col] 
        tile.value = val
    end

    def render
        puts "   #{(0...grid.length).to_a.join(" ")}"
        grid.each_with_index do |row, i|
          puts " #{i} #{row.join(" ")}"
        end
    end

    def columns
        grid.transpose
    end

    def squares
        (0..8).to_a.map { |i| square(i) }
    end

    def solved?
        grid.all? { |row| solve_set?(row) } &&
        columns.all? { |col| solve_set?(col) } && 
        squares.all? { |square| solve_set?(square) }
    end

    def solve_set?(tiles)
        num_values = tiles.map { |el| el.value }
        num_values.sort! == (1..9).to_a
    end

    def square(idx)
        tiles = []
        x = (idx / 3) * 3
        y = (idx % 3) * 3  
        (x...x + 3).each do |i|
          (y...y + 3).each do |j|
            tiles << self[[i, j]]
          end
        end   
        tiles
    end

    private

    attr_reader :grid
end
