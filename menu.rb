require './scale_finder'

class MusicApp 
    def initialize
    end

    def welcome
        puts "     Welcome to Terminal Music."
    end

    def display_scales
        puts "To get started, please choose a scale."
        puts "-" * 38
        puts "1 Major Scale"
        puts "2 Harmonic Minor Scale"
        puts "3 Blues Scale"
        puts "-" * 38
        puts "You can exit the program at any time by pressing ctrl/cmd + c"
    end

    def display_next
        puts "Would you like to save notes from this scale to a file?"
    end
end

# c = MusicApp.new
# c.welcome
# c.display_scales