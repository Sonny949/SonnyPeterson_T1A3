require 'tty-prompt'
require 'tty-font'
require_relative './scale_finder'

begin
  parse = ARGV
  case 
  when (parse & ['-h', '--help']).any?
    File.foreach('./supporting_documents/help.txt') do |line|
      puts line
    end
    exit
  when (parse & ['-a', '--about']).any?
    File.foreach('./supporting_documents/about.txt') do |line|
      puts line
    end
    exit
  when (parse & ['-g', '--gems']).any?
    File.foreach('./Gemfile') do |line|
      puts line
    end
    exit
  end
end

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

  def main
    puts `clear`
    puts @pastel.red(@font.write("TerminalMusic"))
    puts @pastel.red"-" * 118
    puts @pastel.green"You can exit the program at any time by pressing ctrl/cmd + c"
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

  def select_scale
    puts `clear`
    puts @pastel.red(@font_two.write("Scale Select"))
    puts @pastel.red("-" * 73)
    @prompt.select("Please choose a scale.") do |menu|
      menu.choice "Major", -> { major }
      menu.choice "Harmonic Minor", -> { minor }
      menu.choice "Blues", -> { blues }
      menu.choice "Back to Main menu", -> { main }
    end
  end

  def major
    puts `clear`
    puts @pastel.green(@font_two.write("Major Scale"))
    puts @pastel.green("-" * 73)
    puts @pastel.green("You have selected the Major Scale.")
    puts @pastel.green("(If you can't see the note you're after, keep pressing the down-arrow!)")
    @note = @prompt.select("Please choose a note:", all_notes, "Back to Main", filter: true)
    if @note == "Back to Main"
      main
    else
      @note = MajorScale.new(@note)
      puts @pastel.green("Your scale is:")
      puts note.major_scale
      @new_scale << @note.major_scale
      puts @pastel.green("-" * 73)
      save_yes
    end
  end

  def minor
    puts `clear`
    puts @pastel.yellow(@font_two.write("Harmonic Minor"))
    puts @pastel.yellow("-" * 99)
    puts @pastel.yellow("You have selected the Harmonic Minor Scale.")
    puts @pastel.yellow("(If you can't see the note you're after, keep pressing the down-arrow!)")
    @note = @prompt.select("Please choose a note:", all_notes, "Back to Main", filter: true)
    if @note == "Back to Main"
      main
    else
      @note = HarmonicMinorScale.new(@note)
      puts @pastel.yellow("Your scale is:")
      puts @note.harmonic_minor_scale
      @new_scale << @note.harmonic_minor_scale
      puts @pastel.yellow("-" * 99)
      save_yes
    end
  end

  def blues
    puts `clear`
    puts @pastel.blue(@font_two.write("Blues Scale"))
    puts @pastel.blue("-" * 68)
    puts @pastel.blue("You have selected the Blues Scale.")
    puts @pastel.blue("(If you can't see the note you're after, keep pressing the down-arrow!)")
    @note = @prompt.select("Please choose a note:", all_notes, "Back to Main", filter: true)
    if @note == "Back to Main"
      main
    else
      @note = BluesScale.new(@note)
      puts @pastel.blue("Your scale is:")
      puts note.blues_scale
      @new_scale << @note.blues_scale
      puts @pastel.blue("-" * 68)
      save_yes
    end
  end

  def save_yes
    answer = @prompt.select("Would you like to create a save file based on your Scale?", %w(yes no))
    if answer == "yes"
      savefile
    else
      prompt.keypress("Press space or enter when you're ready to return to the main-menu.", keys: [:space, :return])
      main
    end
  end

  def savefile
    @filename = @prompt.ask("What would you like to call your file?", required: true)
    while File.exist?("./new_file/#{@filename}.txt")
      puts "This file name is already in use!"
      @filename = @prompt.ask("What would you like to call your file?", required: true)
    end
    @progression = @prompt.ask("Add some notes separated by a comma.") do |q|
      q.convert -> (input) { input.split(/,\s*/) }
    end
    @filename = File.write("./new_file/#{@filename}.txt", @progression)
    puts "Your file has been saved!"
    sleep(2)
    main
  end

  def edit
    puts `clear`
    puts @pastel.red(@font_two.write("Edit"))
    puts @pastel.red("-" * 26)
    @show_files = @prompt.select("Which File would you like to Edit?", Dir.glob("./new_file/**/*.txt"), "Back to Main")
    if @show_files == "Back to Main" then main
    else
      puts @pastel.yellow("Your current notes are: " + File.read(@show_files))
      change = @prompt.ask("Over-write your file. If you wish to keep old notes be sure to write them back in!") do |q|
      q.convert -> (input) { input.split(/,\s*/) }
    end
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
    @delet_this = @prompt.select("Which File would you like to delete?", Dir.glob("./new_file/**/*.txt"), "Back to Main")
    if @delet_this == "Back to Main" then main
    else
      File.delete(@delet_this)
      puts @pastel.green("Your file has been deleted!")
      sleep(2)
      main
    end
  end

  def help
    File.foreach('./supporting_documents/help.txt') do |line|
        puts  line
    end
    prompt.keypress("Press space or enter when you're ready to return to the main-menu.", keys: [:space, :return])
    main
  end

  def about
    File.foreach('./supporting_documents/about.txt') do |line|
      puts  line
    end
    prompt.keypress("Press space or enter when you're ready to return to the main-menu.", keys: [:space, :return])
    main
  end

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