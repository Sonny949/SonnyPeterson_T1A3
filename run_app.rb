#!/usr/bin/env ruby
require 'tty-prompt'
require 'tty-font'
require 'colorize'
require 'optparse'
require_relative './scale_finder'

# puts "Hello world"

# music = MusicApp.new

# music.welcome

# music.display_scales

# options = {}
# OptionParser.new do |parser|
#     parser.on("-n", "--name NAME", "The name of the person") do |value|
#         options[:name] = value
#     end
#     end.parse!
#     if options[:name]
#         puts 'hello ' + options[:name]
#     else
#         puts 'hello stranger'
#     end
class Selections
    attr_reader :prompt
    attr_accessor :note, :new_scale

    def initialize
        @prompt = TTY::Prompt.new
        @note = note
        @@new_scale = []
    end

    def select_scale
        puts "                Welcome to Terminal Music."
        puts "-" * 61
        puts "You can exit the program at any time by pressing ctrl/cmd + c"
        puts "-" * 61
        @prompt.select("To get started, please choose a scale.") do |menu|
            menu.choice "Major", -> { major }
            menu.choice "Harmonic Minor", -> { minor }
            menu.choice "Blues", -> { blues }
            # menu.choice "Exit", exit
        end
    end

    def major
        puts "You have selected the Major Scale.".green
        puts "(If you can't see the note you're after, keep pressing the down-arrow!)".green
        @note = @prompt.select("Please choose a note", all_notes)
        @note = MajorScale.new(@note)
        puts "Your scale is:".green
        puts note.major_scale
        puts "-"*61
    end

    def minor
        puts "You have selected the Harmonic Minor Scale.".yellow
        puts "(If you can't see the note you're after, keep pressing the down-arrow!)".yellow
        @note = @prompt.select("Please choose a note", all_notes)
        @note = HarmonicMinorScale.new(@note)
        puts "Your scale is:".yellow
        puts @note.harmonic_minor_scale
        @@new_scale << @note.harmonic_minor_scale
        puts "-"*61
    end

    # def save_yes
    #     puts @@new_scale
    #     @prompt.select("Would you like to create a save file based on your array?", %w(yes no))
    #         if "yes" then open = File.new('music.txt', 'w')
    #     end
    # end

    # def leave
        
    # end
end

music = Selections.new
music.select_scale
# music.save
# prompt.select("Which note would you like to use?", Major Harmonic-Minor Blues))