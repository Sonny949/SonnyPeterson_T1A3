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
        every_note << note + "#" unless note == "B" or note == "E"
    end
return every_note
end
# puts natural_notes
puts all_notes


# def notes.each do |note|
#     all_notes = []
#     unless note == "B" or note == "E"
#         all_notes << note
#         all_notes << note + "#"
