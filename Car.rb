class Car
	def initialize(engine, noise)
		@engine = engine
		@noise = noise
	end
	def makes_noise
		puts @noise + @engine.makes_noise
	end
end

class Engine
	def initialize(noise)
		@noise = noise
	end
	def makes_noise
		@noise
	end
end

engine1 = Engine.new("BROOOM")

car1 = Car.new(engine1, "SHAKALAKA ")
car1.makes_noise