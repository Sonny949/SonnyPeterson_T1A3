# class Notes
#     attr_reader :notes

#     def initialize
#         @notes = []
#     end

#     def to_s
#         return "#{@notes}"
#     end
# end

# class NaturalNotes < Notes
#     attr_reader :notes

#     def initialize
#         super(notes)
#     end

# end

def natural_notes
    @notes = ("A".."G").to_a
end

puts natural_notes

# def notes.each do |note|
#     all_notes = []
#     unless note == "B" or note == "E"
#         all_notes << note
#         all_notes << note + "#"
