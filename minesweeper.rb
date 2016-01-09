require_relative 'Board_class'

class Minesweeper

  def initialize
    @board = Board.new
  end

  def play
    @board.render
    over = false

    start_time = Time.now.sec

    until over
      if @board.grid.flatten.none? {|tile| tile.tile_value == "*"}
        puts "You win!"
        puts "The game lasted #{Time.now.sec - start_time} seconds."
        return
      end

      puts "Pick a position"
      move = get_move
      x, y, f_or_r = move
      if f_or_r == "r"
        if @board.grid[x][y].bomb
          @board.explode_bombs
          puts "Game over"
          over = true
        else
          @board.grid[x][y].reveal([x, y])
        end
      elsif f_or_r == "f"
        @board.grid[x][y].tile_value = "F"
      end

      @board.render
    end
  end

  def get_move
    move = gets.chomp.split(",")
    move[0..1] = move[0..1].map {|el| el.to_i}
    move
  end

end

m = Minesweeper.new
m.play
