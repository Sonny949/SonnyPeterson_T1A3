require 'tty-prompt'
require 'tty-font'
require_relative './scale_finder'

begin
  parse = ARGV
  if (parse & ['-h', '--help']).any?
    File.foreach('./supporting_documents/help.txt') do |line|
      puts line
    end
    exit
  elsif (parse & ['-a', '--about']).any?
    File.foreach('./supporting_documents/about.txt') do |line|
      puts line
    end
    exit
  elsif (parse & ['-g', '--gems']).any?
    File.foreach('./Gemfile') do |line|
      puts line
    end
    exit
  end
end

# This is the main body of the app
class Selections
  attr_reader :prompt, :font, :font_two, :pastel
  attr_accessor :note, :new_scale, :filename, :progression, :show_files

  def initialize
    @pastel = Pastel.new
    @font = TTY::Font.new("3d")
    @font_two = TTY::Font.new(:standard)
    @prompt = TTY::Prompt.new
    @note = note
    @filename = filename
    @show_files = show_files
    @new_scale = []
  end

  # Main Menu. Utilising TTY-prompt to branch to all features
  def main
    puts `clear`
    puts @pastel.red(@font.write("TerminalMusic"))
    puts @pastel.red "-" * 118
    puts @pastel.green "You can exit the program at any time by pressing ctrl/cmd + c"
    puts @pastel.red "-" * 118
    prompt.select("Welcome to Terminal Music. Select an option to get started") do |main|
      main.choice "Select a Scale", -> { select_scale }
      main.choice "Edit a File", -> { edit }
      main.choice "Delete a File", -> { delete }
      main.choice "Help", -> { help }
      main.choice "About", -> { about }
      main.choice "Exit", -> { exit_program }
    end
  end

  # Select a scale with tty. branches to choice
  def select_scale
    puts `clear`
    puts @pastel.red(@font_two.write("Scale Select"))
    puts @pastel.red "-" * 73
    @prompt.select("Please choose a scale.") do |menu|
      menu.choice "Major", -> { major }
      menu.choice "Harmonic Minor", -> { minor }
      menu.choice "Blues", -> { blues }
      menu.choice "Back to Main menu", -> { main }
    end
  end

  # Gives options to pick a note. runs note through MajorScale sends to save_file on completion
  def major
    puts `clear`
    puts @pastel.green(@font_two.write("Major Scale"))
    puts @pastel.green "-" * 73
    puts @pastel.green "You have selected the Major Scale."
    puts @pastel.green "(If you can't see the note you're after, keep pressing the down-arrow!)"
    @note = @prompt.select("Please choose a note:", all_notes, "Back to Main", filter: true, cycle: true)
    if @note == "Back to Main"
      main
    else
      @note = MajorScale.new(@note)
      puts @pastel.green "Your scale is:"
      puts note.major_scale
      # creating array based on given note from tty
      @new_scale << @note.major_scale
      puts @pastel.green "-" * 73
      save_yes
    end
  end

  # Gives options to pick a note. runs note through HarmonicMinorScale sends to save_file on completion
  def minor
    puts `clear`
    puts @pastel.yellow(@font_two.write("Harmonic Minor"))
    puts @pastel.yellow "-" * 99
    puts @pastel.yellow "You have selected the Harmonic Minor Scale."
    puts @pastel.yellow "(If you can't see the note you're after, keep pressing the down-arrow!)"
    @note = @prompt.select("Please choose a note:", all_notes, "Back to Main", filter: true, cycle: true)
    if @note == "Back to Main"
      main
    else
      @note = HarmonicMinorScale.new(@note)
      puts @pastel.yellow "Your scale is:"
      puts @note.harmonic_minor_scale
      # creating array based on given note from tty
      @new_scale << @note.harmonic_minor_scale
      puts @pastel.yellow "-" * 99
      save_yes
    end
  end

  # Gives options to pick a note. runs note through BluesScale sends to save_file on completion
  def blues
    puts `clear`
    puts @pastel.blue(@font_two.write("Blues Scale"))
    puts @pastel.blue "-" * 68
    puts @pastel.blue "You have selected the Blues Scale."
    puts @pastel.blue "(If you can't see the note you're after, keep pressing the down-arrow!)"
    # Give array of notes to choose from. 
    @note = @prompt.select("Please choose a note:", all_notes, "Back to Main", filter: true, cycle: true)
    if @note == "Back to Main"
      main
    else
      @note = BluesScale.new(@note)
      puts @pastel.blue "Your scale is:"
      puts note.blues_scale
      # creating array based on given note from tty
      @new_scale << @note.blues_scale
      puts @pastel.blue "-" * 68
      save_yes
    end
  end

  # asks user whether or not they would like to save and sends them to savefile if yes.
  def save_yes
    answer = @prompt.select("Would you like to create a save file based on your Scale?", %w(yes no))
    if answer == "yes"
      savefile
    else
      # If no freezes on note array screen until the user presses space or enter.
      prompt.keypress("Press space or enter when you're ready to return to the main-menu.", keys: [:space, :return])
      main
    end
  end

  def savefile
    @filename = @prompt.ask("What would you like to call your file?", required: true)
    # checks whether save file name already exists
    while File.exist?("./new_file/#{@filename}.txt")
      puts "This file name is already in use!"
      # Asks user to enter a file name.
      @filename = @prompt.ask("What would you like to call your file?", required: true)
    end
    # Asks user to input notes for save file
    @progression = @prompt.ask("Add some notes separated by a comma.") do |q|
      q.convert -> (input) { input.split(/,\s*/) }
    end
    # Saves file
    @filename = File.write("./new_file/#{@filename}.txt", @progression)
    puts "Your file has been saved!"
    sleep(2)
    main
  end

  def edit
    puts `clear`
    puts @pastel.red(@font_two.write("Edit"))
    puts @pastel.red("-" * 26)
    # Displays files and asks user to pick one to edit
    @show_files = @prompt.select("Which File would you like to Edit?", Dir.glob("./new_file/**/*.txt"), "Back to Main", filter: true, cycle: true)
    # Option to return to main menu
    if @show_files == "Back to Main" then main
    else
      # Displays notes and asks user to overwrite
      puts @pastel.yellow("Your current notes are: " + File.read(@show_files))
      change = @prompt.ask("Over-write your file. If you wish to keep old notes be sure to write them back in!") do |q|
      q.convert -> (input) { input.split(/,\s*/) }
      end
      # Saves new notes
      File.open(@show_files, "w") { |f| f.write change }
      puts @pastel.yellow("Your File has been over-written!")
      sleep(2)
      main
    end
  end

  def delete
    puts `clear`
    puts @pastel.red(@font_two.write("Delete"))
    puts @pastel.red("-" * 39)
    # display file directory
    @delet_this = @prompt.select("Which File would you like to delete?", Dir.glob("./new_file/**/*.txt"), "Back to Main", filter: true, cycle: true)
    # Back to main
    if @delet_this == "Back to Main" then main
    else
      # Deletes file
      File.delete(@delet_this)
      puts @pastel.green("Your file has been deleted!")
      sleep(2)
      main
    end
  end

  # Displays help.txt
  def help
    File.foreach('./supporting_documents/help.txt') do |line|
        puts line
    end
    # waits for prompt to return to menu
    prompt.keypress("Press space or enter when you're ready to return to the main-menu.", keys: [:space, :return])
    main
  end

  # Display about.txt
  def about
    File.foreach('./supporting_documents/about.txt') do |line|
      puts  line
    end
    # waits for prompt to return to menu
    prompt.keypress("Press space or enter when you're ready to return to the main-menu.", keys: [:space, :return])
    main
  end

  # Shows graphic then clears and exits terminal
  def exit_program
    puts @pastel.red("---")
    sleep(0.5)
    puts @pastel.red("---")
    sleep(0.5)
    puts @pastel.red("---")
    sleep(0.5)
    puts pastel.red("--->")
    puts @pastel.red(@font_two.write("Goodbye"))
    puts @pastel.red("-" * 55)
    sleep(2)
    puts `clear`
  end
end

music = Selections.new

begin
  music.main
rescue Interrupt
  puts "\n"
  music.exit_program
rescue StandardError => e
  puts "An unexpected error occurred"
  p e.message
end
