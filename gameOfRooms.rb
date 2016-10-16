class Player
    attr_accessor :x, :y, :lives, :objects
    def initialize(x=0, y=0, lives = 5)
        @x = x
        @y = y
        @lives = lives
        @objects = []
    end

    def takelife
        @lives -= 1
    end

    def pickup(object)
        @objects.push(object)
        puts "You have picked up a #{object.name}"
    end

    def drop(object)
        @objects.delete(object)
        puts "You have thrown a #{object.name}"
    end 
end

class Room
    attr_reader :clue, :finalroom, :objects
    def initialize(clue, objects = [] ,finalroom = false)
        @clue = clue
        @finalroom = finalroom
        @objects = objects
    end

    def remove_object(object)
        @objects.delete(object)
    end

    def add_item(object)
        @objects.push(object)
    end
end

class Item
    attr_reader :name
    def initialize(name)
        @name = name
    end
end

class Game
    attr_reader :rooms, :player
    def initialize(player, won, height=10, width=10)
        @rooms = Array.new(height){Array.new(width)}
        @player = player
        @won = false
    end

    def add_room(x, y, room)
        @rooms[x][y] = room
    end

    def play
        puts @rooms[@player.x][@player.y].clue

        while(!@won && @player.lives > 0)
            puts"Input your action here: "
            action = gets.chomp.upcase
            action_maker(action)
        end
        if (@player.lives == 0)
            puts "You lose"
        else
            puts "You win"
        end
    end


    private

    def items(room)
        if room.objects == []
            puts 'No items to pick up'

        else
            room.objects.each do |object| 
                puts "There is a #{object.name}."
            end
            pick_up_object(room)
        end

    end

    def pick_up_object(room)
        puts"Input the object here: "
        object = gets.chomp
        finalobject = room.objects.find do |item|
            object == item.name
        end
        if finalobject == nil
            puts"incorrect name"
        else
            @rooms[@player.x][@player.y].remove_object(finalobject)
            @player.pickup(finalobject)
        end
    end

    def drop_object()
        puts"Drop the object: "
        object = gets.chomp
        finalobject = @player.objects.find do |item|
            object == item.name
        end
        if finalobject == nil
            puts"incorrect name"
        else
            @player.drop(finalobject)
            @rooms[@player.x][@player.y].add_item(finalobject)
        end
    end

    def show_inventory
        if @player.objects == []
            puts "You dont have any objects"
        else
            @player.objects.each {|item| puts item.name}
        end
    end

    def move_room (x, y)
        @player.x += x
        @player.y += y
        if(@rooms[@player.x][@player.y] == nil)
            @player.x -= x
            @player.y -= y
            @player.takelife
            puts "There is no exit there."
            puts "You have #{@player.lives} more lives"
        end
    end

    def action_maker(action)
        puts case action
        when "N"
            move_room(0, 1)

        when "S"
            move_room(0, -1)

        when "E"
            move_room(1, 0)

        when "W"
            move_room(-1, 0)

        when "PICK UP"
            items(@rooms[@player.x][@player.y])

        when "DROP"
            drop_object

        when "INVENTORY"
            show_inventory

        else
            puts"I don't understand"

        end

        if (@rooms[@player.x][@player.y].finalroom)
            @won = true

        elsif @player.lives != 0
            puts @rooms[@player.x][@player.y].clue
        end

    end
end



player1 = Player.new

game = Game.new(player1, false)

startroom = Room.new("You are in the start room")
room1 = Room.new("Welcome to the first room" , [Item.new("sword"),Item.new("shield")])
room2 = Room.new("Welcome to the second room")
endroom = Room.new("Congrats, you win",[], true)

game.add_room(0, 0, startroom)
game.add_room(0, 1, room1)
game.add_room(1, 1, room2)
game.add_room(1, 2, endroom)

game.play

binding.pry