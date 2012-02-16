class Square
	attr_reader :x
	attr_reader :y

	def initialize(x, y, player=nil)
		@x, @y, @player  = x, y, player
	end

	def display
		output = ""
    output += y.to_s if @x == 0
		output += " #{player_symbol} "
		output += if @x == Board::WIDTH - 1
							  "\n"
							else
						    "|"
							end

		output
	end

	def player=(player)
		@player = player
	end

	def player_symbol
		@player.nil? ? " " : @player.symbol
	end
end

class Player
	attr_accessor :symbol

	def initialize(board, symbol)
		@board = board
		@symbol = symbol
	end

	def pick(x,y)
	  @board.pick(x.to_i,y.to_i, self)
	end
end

class Board
	WIDTH = 3
	HEIGHT = 3

	attr_accessor :grid

	def initialize
		@grid = Array.new(3) { Array.new(3) }				
		0.upto(HEIGHT - 1) do |row|
		  0.upto(WIDTH - 1) do |column|
				@grid[row][column] = Square.new(column, row)
			end
		end
	end

	def pick(x,y, player)
		@grid[y][x].player = player
	end

	def display
		puts "  0   1   2    X"
		@grid.each_with_index do |row, row_index|
			row.each do |column|
				print column.display
			end
			puts "  -----------" unless row_index == HEIGHT - 1
		end
		puts "\nY\n"
	end
end

def check_for_winner(board)
	raise board.grid[0][0].player_symbol if board.grid[0][0] == board.grid[0][1] && board.grid[0][1] == board.grid[0][2] 
end

board = Board.new
players = [Player.new(board, 'X'), Player.new(board, 'O')]

current_player_index = (rand() * players.length).to_i
while true do
	system("clear")
  board.display
	x = gets
	y = gets
  players[current_player_index].pick(x, y)
  current_player_index = current_player_index == 0 ? 1 : 0 
	check_for_winner(board)
end

