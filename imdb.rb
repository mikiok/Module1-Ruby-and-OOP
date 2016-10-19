require 'imdb'
require 'colorize'


class Movies
	@@file = "movies.txt"
	@@movies = ""

	def self.get_movies
		@@movies = IO.read(@@file).split("\n")
	end

	def self.print_movies
		for index in 1..@@movies.size
			puts "#{index}. #{@@movies[index-1]}"
		end
	end
end

class Ratings
	@@ratings = []
	def self.get_ratings
		movies = Movies.get_movies
		movies.each do |movie|
			i = Imdb::Search.new(movie)
			@@ratings.push(i.movies[0].rating.round)
		end
		@@ratings
	end
	def self.get_max_rating
		max = 0
		@@ratings.each do |rating|
			if(rating > max)
				max = rating
			end
		end
		max
	end

	def self.get_rates
		@@ratings
	end
end

class ASCIIchart
	@@result = ""

	def self.print_chart
		puts @@result += put_ratings_chart + put_line + put_indexes
	end

	private

	def self.put_ratings_chart
		chart = ""
		counter = Ratings.get_max_rating
		while (counter >= 0)
			for element in Ratings.get_rates
				if (element >= counter)
					chart += "|#"
				else
					chart += "| "
				end
			end
			chart += "|\n"
			counter -= 1
		end
		chart
	end

	def self.put_line
		line =""
		for element in Movies.get_movies
			line+="--"
		end
		line += "-\n"
	end

	def self.put_indexes
		indexes = ""
		for index in 1..Ratings.get_rates.size
			indexes += "|#{index}"
		end
		indexes += "|\n\n"
	end

end

Ratings.get_ratings
ASCIIchart.print_chart
Movies.print_movies