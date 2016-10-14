class Home
  attr_reader(:name, :city, :capacity, :price)

  def initialize(name, city, capacity, price)
    @name = name
    @city = city
    @capacity = capacity
    @price = price
  end
end



#Iteration #0: Create an array of homes

homes = [
  Home.new("Nizar's place", "San Juan", 2, 42),
  Home.new("Fernando's place", "Albamasilla del monte", 5, 47),
  Home.new("Josh's place", "Pittsburgh", 3, 41),
  Home.new("Gonzalo's place", "Málaga", 2, 45),
  Home.new("Ariel's place", "San Juan", 4, 49),
  Home.new("Miguel's place", "Pittsburgh", 5, 60),
  Home.new("Juan Carlos' place", "Albamasilla del monte", 7, 39),
  Home.new("Ignacio's place", "Albamasilla del monte", 1, 43),
  Home.new("Gonzalo's place", "Málaga", 4, 57),
  Home.new("Gerardo's place", "Pittsburgh", 3, 45)
]



#Iteration #1: List of homes

homes.each do |home|
	puts"#{home.name} in #{home.city}\nPrice: $#{home.price} a night"
end



#Iteration #2: Sorting

ordered_homes = homes.sort do |home1, home2|
	home1.price <=> home2.price
end

ordered_homes.each do |home|
	puts"#{home.name} in #{home.city}\nPrice: $#{home.price} a night"
end



#Iteration #3: Filter by city

puts "1: Sort by price"
puts "2: Sort by capacity"
option = gets.chomp.to_i

if option == 1
	ordered_homes = homes.sort do |home1, home2|
		home2.price <=> home1.price
	end


elsif option == 2
	ordered_homes = homes.sort do |home1, home2|
		home1.capacity <=> home2.capacity
	end
end

ordered_homes.each do |home|
	puts"#{home.name} in #{home.city}\nPrice: $#{home.price} a night"
end



#Iteration #4: Average

puts "Choose a city to filter homes: "
cityToFilter = gets.chomp
filtered_homes = homes.select do |home|
	home.city == cityToFilter
end

filtered_homes.each do |home|
	puts"#{home.name} in #{home.city}\nPrice: $#{home.price} a night"
end


puts filtered_homes.reduce(0.0) {|average, home| average + home.price/filtered_homes.length}



#Iteration #5: Name your own price

puts "Choose a price to filter homes: "
filterPrice = gets.chomp.to_i
home_byPrice = filtered_homes.find do |home|
	home.price == filterPrice
end

puts"#{home_byPrice.name} in #{home_byPrice.city}\nPrice: $#{home_byPrice.price} a night"