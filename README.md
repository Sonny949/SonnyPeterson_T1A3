# Music Scales App

This is a simple terminal driven application written in Ruby to display common scales related to any given musical note. It also allows a user to save the scale to an outside file or save notes from the scale in no specific order. It was designed for beginner musicians to not only easily find common scales related to any given note, but to be able to save notes from the scales in an order that they find pleasing to the ear as they play through the scales on their instrument. These notes may later be turned into a song by saving to an external text file.

## Source Control

[Git Hub Repo](https://github.com/Sonny949/SonnyPeterson_T1A3)

## Style

I did my best to adhere to [The Ruby Style Guide](https://rubystyle.guide/), enforced by Rubocop.

## Planning

I used a Kanban board from Trello to plan tasks for this app. I implemented the Agile method, driven by user stories. The board can be found [here.](https://trello.com/b/rgTduGVB/terminal-app)

## Instructions for Installation

Please click the code button at the top right of this page. Clone the repository or use any other method you wish to download. More information on cloning can be found [here.](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)

To run the application, navigate into the src folder, type `./run_app.sh`, and press enter/return. The gem bundler/gem bundle will be installed and you will on your way to making music!

## Using Terminal music (Including Features)

From terminal (outside of application run), you can access help docs by typing `ruby app.rb -h` or `ruby app.rb --help` from the src folder. Similarly, you can access about docs or view the Gemfile with `ruby app.rb -`/`ruby app.rb --about` and `ruby app.rb -g`/`ruby app.rb --gems` respectively.

During app playback, almost everything is navigated with the up/down keys and enter.

To view a scale, navigate to ***'Select a Scale'*** and press enter. Then navigate to your desired scale and press enter. You will be presented with the full array of musical notes. Choose one either through navigation or by tpying the note on the keyboard. If you decide the filter you've selected is not right, press backspace. once a note has been chosen, the previously selected scale for the note will be displayed. You will be asked whether you would like to ***'create a save file'***. If you select 'no', the app will freeze while you regard the scale. Press enter/return or space to return to the main menu. If you choose 'yes', you will be prompted to name your file. Refer to the 'Help' docs for this process if you are unsure of how to name your file or select notes for your progression. After you finish your file will save and you will be returned to the main menu.

In ***'Edit a File'***, a list of available files will be displayed. Select your file to edit. Please refer to the help docs for more information regarding edit. If your file is not displayed, it no longer exists within the program files.

***'Delete a File'*** works exactly like 'Edit a file' **be careful though**, if you press enter while navigating over a file there is no way to bring it back.

'Help' shows the help docs.

'About' shows the purpose of the app and the reasons for the app's creation.

'Exit' will exit the program.

## Requirements

Please adjust your terminal so the window size is at least 120 x 30 for optimum playback.

This App requires the use of a bash or linux operating system such as Ubuntu for windows.

This app requires Ruby installed on your computer, and a ruby manager. Click [here](https://www.ruby-lang.org/en/documentation/installation/) for help in installation.

### Gems

The Gems I use in this program will be installed when you run `./run-app.sh`. They are as follows

- rails

- rspec, 3.11

- tty, 0.5.0

- tty-font, 0.5.0

- pastel, 0.6.1