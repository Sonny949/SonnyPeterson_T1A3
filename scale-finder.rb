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
# puts all_notes



def major_scale(root_note)
    major_scale = []
    current_note_index = all_notes.index(root_note)
    whole = 2
    half = 1
    [whole, whole, half, whole, whole, whole, half].each do |next_major_scale_step|
        note_of_scale = all_notes[current_note_index]
        major_scale << note_of_scale
        next_major_scale_step.times do
            current_note_index += 1
            current_note_index = 0 if all_notes[current_note_index].nil?
        end
    end
    return major_scale
end

puts major_scale("C")