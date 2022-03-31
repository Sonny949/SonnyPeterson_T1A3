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
    attr_reader :prompt, :font, :pastel
    attr_accessor :note, :new_scale, :filename, :progression

    def initialize
        @pastel = Pastel.new
        @font = TTY::Font.new(:starwars)
        @prompt = TTY::Prompt.new
        @note = note
        @filename = filename
        @@new_scale = []
    end

    def main
        puts `clear`
        puts @pastel.red(@font.write("Terminal Music"))
        puts @pastel.red"-" * 134
        puts @pastel.green"You can exit the program at any time by pressing ctrl/cmd + c"
        puts @pastel.red"-" * 134
        prompt.select("Welcome to Terminal Music. Select an option to get started") do |main|
            main.choice "Select a Scale", -> { select_scale }
            main.choice "Edit a File", -> { edit }
            main.choice "Exit", -> { exit_program }
        end
    end

    def select_scale
        puts `clear`
        puts @pastel.red(@font.write("Scale Select"))
        puts @pastel.red"-" * 117
        puts @pastel.green"You can exit the program at any time by pressing ctrl/cmd + c"
        puts @pastel.red"-" * 117
        @prompt.select("To get started, please choose a scale.") do |menu|
            menu.choice "Major", -> { major }
            menu.choice "Harmonic Minor", -> { minor }
            menu.choice "Blues", -> { blues }
            menu.choice "Back to Main menu", -> { main }
        end
    end

    def major
        puts "You have selected the Major Scale.".green
        puts "(If you can't see the note you're after, keep pressing the down-arrow!)".green
        @note = @prompt.select("Please choose a note", all_notes)
        @note = MajorScale.new(@note)
        puts "Your scale is:".green
        puts note.major_scale
        @@new_scale << @note.major_scale
        puts "-" * 61
        save_yes
    end

    def minor
        puts "You have selected the Harmonic Minor Scale.".yellow
        puts "(If you can't see the note you're after, keep pressing the down-arrow!)".yellow
        @note = @prompt.select("Please choose a note", all_notes)
        @note = HarmonicMinorScale.new(@note)
        puts "Your scale is:".yellow
        puts @note.harmonic_minor_scale
        @@new_scale << @note.harmonic_minor_scale
        puts "-" * 61
        save_yes
    end

    def blues
        puts "You have selected the Blues Scale.".blue
        puts "(If you can't see the note you're after, keep pressing the down-arrow!)".blue
        @note = @prompt.select("Please choose a note", all_notes)
        @note = BluesScale.new(@note)
        puts "Your scale is:".green
        puts note.blues_scale
        @@new_scale << @note.blues_scale
        puts "-" * 61
        save_yes
    end

    def save_yes
        answer = @prompt.select("Would you like to create a save file based on your array?", %w(yes no))
        if answer == "yes"
            savefile
        else
            main
        end
    end

    def savefile
        @filename = @prompt.ask("What would you like to call your file?")
        @progression = @prompt.ask("Add some notes separated by a comma.") do |q|
            q.convert -> (input) { input.split(/,\s*/) }
        end
        @filename = File.write("./new_file/" + @filename + ".txt", @progression)
        puts "Your file has been saved!"
        sleep(2)
        main
    end

    def edit
        puts "Which File would you like to Edit?"
        sleep(2)
        main
    end

    def exit_program
        puts "Goodbye!"
        puts "-" * 61
    end
end

music = Selections.new
music.main
