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


# show major scale for given root note. w stands for whole step, h stands for half step
def major_scale(root)
    major_scale = []
    note_index = all_notes.index(root)
    w = 2
    h = 1
    [w, w, h, w, w, w, h].each do |next_step_major|
        scale_note = all_notes[note_index]
        major_scale << scale_note
        next_step_major.times do
            note_index += 1
            note_index = 0 if all_notes[note_index].nil?
        end
    end
    return major_scale
end

puts major_scale("C")