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

# we will have three Scales, this master-class will define common variables. w stands for whole step, h stands for half- 
# step. I didn't use a special notation for 3 half steps because in music theory it is always noted as whole + half
class Scale
    attr_reader :root

    def initialize(root)
        @root = root
    end

    def w
        w = 2
    end

    def h
        h = 1
    end
end

# gives the major scale for a given note
class MajorScale < Scale
    attr_accessor :root

    def major_scale
        major_scale = []
        note_index = all_notes.index(root)
        # defined intervals for major scale
        [w, w, h, w, w, w, h].each do |next_step_major|
            scale_note = all_notes[note_index]
            major_scale << scale_note
            next_step_major.times do
                note_index += 1
                # loops back to start of array if reaches the end and has not satisfied the number of hops
                note_index = 0 if all_notes[note_index].nil?
            end
        end
        return major_scale
    end
end

# show harmonic minor related to given note
class HarmonicMinorScale < Scale
    attr_reader :root

    def harmonic_minor_scale
        harmonic_minor_scale = []
        note_index = all_notes.index(root)
        [w, h, w, w, h, w + h, h].each do |next_step_harmonic_minor|
            scale_note = all_notes[note_index]
            harmonic_minor_scale << scale_note
            next_step_harmonic_minor.times do
                note_index += 1
                note_index = 0 if all_notes[note_index].nil?
            end
        end
        return harmonic_minor_scale
    end
end

# show blues scale related to given note
class BluesScale < Scale
    attr_reader :root

    def blues_scale
        blues_scale = []
        note_index = all_notes.index(root)
        [w + h, w, h, h, w + h, w].each do |next_step_blues|
            scale_note = all_notes[note_index]
            blues_scale << scale_note
            next_step_blues.times do
                note_index += 1
                note_index = 0 if all_notes[note_index].nil?
            end
        end
        return blues_scale
    end
end
# d = MajorScale.new("D")
# puts d.major_scale

# c = HarmonicMinorScale.new("C")
# puts c.harmonic_minor_scale

# a = BluesScale.new("D")
# puts a.blues_scale

# keys = ARGV.empty? ? ["C"] : ARGV
# keys.each {|key| }