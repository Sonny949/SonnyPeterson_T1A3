require_relative './scale_finder.rb'

# saving notes based on output from scale_finder
class SaveScale
    attr_accessor :add_notes

    def initialize
        @add_notes = []
    end

    def add_note(note)
        @add_notes << note
    end
end