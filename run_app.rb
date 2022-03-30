#!/usr/bin/env ruby
require 'tty-prompt'
require 'colorize'
require 'optparse'
require_relative './menu'
require_relative './scale_finder'
require_relative './save_scale'

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

    def initialize
        @prompt = TTY::Prompt.new
    end

    def select_scale
        puts "                Welcome to Terminal Music."
        puts "-" * 61
        puts "You can exit the program at any time by pressing ctrl/cmd + c"
        puts "-" * 61
        prompt.select("To get started, please choose a scale.") do |menu|
            menu.choice "Major", -> { major }
            menu.choice "Harmonic Minor", -> { minor }
            menu.choice "Blues", -> { blues }
            # menu.choice "Exit" ->  { exit }
        end
    end

    def major
        puts "You have selected the Major Scale.".green
        puts "(If you can't see the note you're after, keep pressing the down-arrow!)".green
        note = @prompt.select("Please choose a note", all_notes)
        newscale = MajorScale.new(note)
        puts newscale.major_scale
        newscale -> { save }
    end

    def minor
        puts "You have selected the Major Scale.".purple
        puts "(If you can't see the note you're after, keep pressing the down-arrow!)".purple
        note = @prompt.select("Please choose a note", all_notes)
        newscale = HarmonicMinorScale.new(note)
        puts newscale.harmonic_minor_scale
        newscale -> { save }
    end

    def save

    end
end

music = Selections.new
music.select_scale


# prompt.select("Which note would you like to use?", Major Harmonic-Minor Blues))