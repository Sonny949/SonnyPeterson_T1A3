# define 7 natural notes
def natural_notes
    notes = ("A".."G").to_a
    return notes
end

# define sharps/flats
def all_notes
every_note = []
    natural_notes.each do |note|
        every_note << note
        every_note << "#{note}#" unless note == "B" or note == "E"
    end
return every_note
end
# puts natural_notes
puts all_notes

class Scale
    attr_reader :root_note

    def initialize(root_note)
        @root_note = root_note
        @whole = 2
        @half = 1
    end
end

class MajorScale < Scale
    def initialize(root_note)
        super(root_note, whole, half)
    end

    # def major_scale
    
end