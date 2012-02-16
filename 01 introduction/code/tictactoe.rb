class Block
	attr_accessor :y
	attr_accessor :x
	attr_accessor :status
	
	def initialize(opts = {})
		@y = opts[:y]
		@x = opts[:x]
	end

	def display
		output = " #{status_display} "
		output += "|" unless @x == 2
		output
	end

	def status_display
		@status.nil? ?	" " : "X"
	end
end

class Board
	def initialize
		@board = Array.new(3) { Array.new(3) }
		0.upto(2) do |y|
			0.upto(2) do |x|
				@board[y][x] = Block.new(y: y, x: x)
			end
		end
	end

	def display	
		@board.each_with_index do |row, i|
			row.each do |block|
				print block.display
			end
			puts
			unless i == 2
				print " "
				(3*3).times { print "-"}
				puts
			end
		end
		puts
	end

	def tick(x,y)
		@board[y.to_i][x.to_i].status = "taken"
	end
end
			
class Player
end

class AIPlayer
end

class TicTacToe
	def run
		board = Board.new
		board.display
		while true
			puts "Put in x co ordinate"
			x = gets
			puts "Put in y co ordinate"
			y = gets
			board.tick(x,y)
			board.display
		end
	end
end

TicTacToe.new.run
