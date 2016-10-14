class Vehicle
	attr_reader :noise, :wheels
	def initialize(noise, wheels)
		@noise = noise
		@wheels = wheels
	end
	def makes_noise
		puts @noise
	end
end

class Bike < Vehicle
end

class Truck < Vehicle
end

class Car < Vehicle
end

class Wheels
	def initialize(vehicles)
		@vehicles = vehicles
	end
	def count_wheels
		@vehicles.reduce(0) do |wheels, vehicle|
			wheels+vehicle.wheels
		end
	end
end

class Noises
	def initialize(vehicles)
		@vehicles = vehicles
	end
	def prints_noises
		@vehicles.each do |vehicle|
			puts vehicle.noise
		end
	end
end


car1 = Car.new("Broom", 4)
bike1 = Bike.new("Shhh", 2)
truck1 = Truck.new("BROOOOOM", 6)

vehicles = [car1, bike1, truck1]

puts Wheels.new(vehicles).count_wheels
Noises.new(vehicles).prints_noises



