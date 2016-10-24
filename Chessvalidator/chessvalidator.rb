class ChessValidator
	@@results = ""

	def self.start
		Archive.load_positions.each do |pair|
			coordenates = pair.split(" ")
			check_move Board.get_board, coordenates[0], coordenates[1]
		end
	end

	def self.load_result result
		@@results += "#{result}\n"
	end

	def self.check_move board, origin, destination
		origin.split("")
		origin.reverse!
		destination.split("")
		destination.reverse!

		originposition = []
		originposition[0] = Position.get_x_position origin[0]
		originposition[1] = Position.get_y_position origin[1]

		destinationposition = []
		destinationposition[0] = Position.get_x_position destination[0]
		destinationposition[1] = Position.get_y_position destination[1]

		if (board[originposition[0]] [originposition[1]] != nil)

			case board[originposition[0]][originposition[1]]

			when :bR, :wR
				if Roak.check_move board, originposition, destinationposition
					load_result "LEGAL"
				else
					load_result "ILLEGAL"
				end

			when :bN, :wN
				if Knight.check_move board, originposition, destinationposition
					load_result "LEGAL"
				else
					load_result "ILLEGAL"
				end

			when :bB, :wB
				if Bishop.check_move board, originposition, destinationposition
					load_result "LEGAL"
				else
					load_result "ILLEGAL"
				end

			when :bQ, :wQ
				if Queen.check_move board, originposition, destinationposition
					load_result "LEGAL"
				else
					load_result "ILLEGAL"
				end

			when :bK, :wK
				if King.check_move board, originposition, destinationposition
					load_result "LEGAL"
				else
					load_result "ILLEGAL"
				end

			when :bP, :wP
				if Pawn.check_move board, originposition, destinationposition, board[originposition[0]][originposition[1]]
					load_result "LEGAL"
				else
					load_result "ILLEGAL"
				end

			end
		else
			load_result "ILLEGAL"
		end
		Archive.save_results @@results
	end
end




class Archive
	@@file_moves = "complex_moves.txt"
	@@file_savedboard = "complex_board.txt"
	@@file_results = "complex_results.txt"

	def self.load_positions
		positions = IO.read(@@file_moves).split("\n")
	end

	def self.load_saved_board
		board = IO.read(@@file_savedboard).split(" ")
	end

	def self.save_results results
		IO.write(@@file_results, results)
	end

end




class Position
	def self.get_x_position coordenate
		position = coordenate.to_i - 1
		position = 7 - position
	end
	def self.get_y_position coordenate
		position = coordenate.ord % 97
	end
end





class Board
	@@heigth = 8
	@@width = 8
	@@board = Array.new(@@heigth){Array.new(@@width)}

	def self.get_board
		@@board
	end

	def self.load_board
		saved_board = Archive.load_saved_board
		counter = 0
		for x in 0..@@heigth-1
			for y in 0..@@width-1
				if saved_board[counter] == "--"
					@@board[x][y] = nil
				else
					@@board[x][y] = (saved_board[counter]).to_sym
				end
				counter += 1
			end
		end
	end

end





class Piece

	def self.check_straigth board, origin, destination
		((origin[0] != destination[0]) && (origin[1] == destination[1])) || 
			((origin[0] == destination[0]) && (origin[1] != destination[1]))

	end

	def self.check_diagonal board, origin, destination
		((origin[0] - destination[0]).abs) == ((origin[1] - destination[1]).abs)
		
	end

	def self.check_move board, origin, destination
		x = 0
		y = 0
		if ((destination[0] - origin[0]) > 0)
			x = 1
		elsif ((destination[0] - origin[0]) < 0)
			x = -1
		end

		if ((destination[1] - origin[1]) > 0)
			y = 1
		elsif ((destination[1] - origin[1]) < 0)
			y = -1
		end
		move_piece board, origin, destination, x, y
	end

	def self.move_piece board, origin, destination, x, y
		valid = true
		origin_pointx = origin[0]
		origin_pointy = origin[1]
		origin[0] += x
        origin[1] += y

		while (valid && ((origin[0] < destination[0]) || (origin[1] < destination[1])))
        	if board[origin[0]][origin[1]] != nil
        		valid = false
        	end
        	origin[0] += x
        	origin[1] += y
		end
        if (valid && (board[destination[0]][destination[1]] != nil))
        	puts board[origin_pointx][origin_pointy]
        	check_color board[origin_pointx][origin_pointy], board[destination[0]][destination[1]]
        elsif valid
        	true
        else
        	false
        end
    end

    def self.check_color origin_piece, destination_piece
    	colororiginpiece = ""
    	colordestinationpiece = ""
    	if (origin_piece == :bR || origin_piece == :bN || origin_piece == :bK || origin_piece == :bQ || 
    		origin_piece == :bP || origin_piece == :bB)
    		colororiginpiece = "black"
    	end
    	if (destination_piece == :wR || destination_piece == :wN || destination_piece == :wK || destination_piece == :wQ || 
    		destination_piece == :wP || destination_piece == :wB)
    		colordestinationpiece = "white"
    	end
    	if (origin_piece == :wR || origin_piece == :wN || origin_piece == :wK || origin_piece == :wQ || 
    		origin_piece == :wP || origin_piece == :wB)
    		colororiginpiece = "white"
		end
    	if (destination_piece == :bR || destination_piece == :bN || destination_piece == :bK || destination_piece == :bQ || 
    		destination_piece == :bP || destination_piece == :bB)
    		colordestinationpiece = "black"
    	end

    	colororiginpiece != colordestinationpiece
    end
end


class Roak < Piece
	def self.check_move board, origin, destination
		if check_straigth(board, origin, destination)
			super board, origin, destination
		end
	end
end

class King < Piece
	def self.check_move board, origin, destination
		if ((origin[0] - destination[0]).abs<=1) && ((origin[1] - destination[1]).abs<=1)
			super board, origin, destination
		end
	end
end

class Queen < Piece
	def self.check_move board, origin, destination
		if check_straigth(board, origin, destination) || check_diagonal(board, origin, destination)
			super board, origin, destination
		end
	end
end

class Bishop < Piece
	def self.check_move board, origin, destination
		if check_diagonal board, origin, destination
			super board, origin, destination
		end
	end
end

class Knight < Piece
	def self.check_move board, origin, destination
		if (((origin[0] - destination[0]).abs==2) && ((origin[1] - destination[1]).abs==1))||
			(((origin[0] - destination[0]).abs==1) && ((origin[1] - destination[1]).abs==2))
			true
		end
	end
end

class Pawn < Piece
	def self.check_move board, origin, destination, color
		if ((color == :bP) && ((origin[0] - destination[0]).abs<=2) && (origin[0] == 1) && check_straigth(board, origin, destination))
			super board, origin, destination
		elsif ((color == :wP) && ((origin[0] - destination[0]).abs<=2) && (origin[0] == 6) && check_straigth(board, origin, destination))
			super board, origin, destination
		elsif ((color == :bP) && ((origin[0] - destination[0])==-1) && check_straigth(board, origin, destination))
			super board, origin, destination
		elsif ((color == :wP) && ((origin[0] - destination[0])==1) && check_straigth(board, origin, destination))
			super board, origin, destination
		end
	end
end

Board.load_board
ChessValidator.start