#require_relative 'Board_class'

class Tile
  DIRS =
  [ [-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1] ]

  attr_accessor :bomb, :revealed, :tile_value

  def initialize(board = nil)
    @bomb = false
    @revealed = false
    @board = board
    @tile_value = "*"
  end

  # def bomb?
  #   @bomb
  # end

  def reveal(pos)
    if @bomb
      @tile_value = "B"
      @revealed = true
      return nil
    else
      return nil if @revealed
      @revealed = true
      adjacent_tiles = neighbors(pos)
      num_bombs = neighbor_bomb_count(adjacent_tiles)
      if num_bombs == 0
        @tile_value = "-"
        adjacent_tiles.each do |adj_tile|
          i, j = adj_tile
          @board.grid[i][j].reveal(adj_tile)
        end
      else
        @tile_value = num_bombs
        return nil
      end
    end
  end

  def neighbors(current_tile)
    row, col = current_tile
    adjacent_tiles = []

    DIRS.each do |neighbor_pos|
      x, y = [neighbor_pos.first + row, neighbor_pos.last + col]
      adjacent_tiles << [x, y] if x.between?(0, 8) && y.between?(0, 8)
    end

    adjacent_tiles
  end

  def neighbor_bomb_count(adjacent_tiles)
    num_bombs = 0
    adjacent_tiles.each do |adj_pos|
      i, j = adj_pos
      if @board.grid[i][j].bomb
        num_bombs += 1
      end
    end
    num_bombs
  end

end
#
# t = Tile.new
# p t.neighbors([4,4])
