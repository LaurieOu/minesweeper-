require_relative 'Tile_class'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) { Tile.new(self) } }

    seed_bombs
  end

  def seed_bombs
    bomb_positions = []

    until bomb_positions.length == 10
      x = rand(9)
      y = rand(9)
      unless bomb_positions.include?([x, y])
        @grid[x][y].bomb = true
        bomb_positions << [x, y]
      end
    end
  end

  def explode_bombs
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        tile = @grid[row_idx][col_idx]
        tile.reveal([row_idx, col_idx]) if tile.bomb
      end
    end
    render
  end

  def render
    first_row = "  "
    9.times { |num| first_row += "#{num} " }
    start = 0
    puts first_row
    @grid.each_with_index do |row, row_idx|
      printed_row = "#{start} "
      row.each_with_index do |tile, col_idx|
        printed_row << "#{tile.tile_value} "
      end
      start += 1
      puts printed_row
    end
  end

end

# b = Board.new
# b.grid[2][5].reveal([2,5])
# b.render
