require "./scale_finder"
require "./save_scale"

# app will show scales related to notes
describe natural_notes do
    it 'should give value of index' do
        allow(natural_notes[0]).to receive(:gets).and_return("A")
    end
end

describe all_notes do
    it "should be 12 in length" do
        expect(all_notes.length).to be(12)
    end
end

describe Scale do
    it "creates an instance of scale class" do
    c = Scale.new("C")
    expect(c).to be_kind_of(Scale)
    end
end

describe MajorScale do
    it "returns scale based on root note" do
        c = MajorScale.new("C")
        expect(c).to be_kind_of(MajorScale)
        expect(c.major_scale[4]).to eq("G")
    end
end

describe SaveScale do
    it "saves notes to an array" do
        c = SaveScale.new
        c.add_note("C")
        expect(c.add_notes[0]).to eq("C")
    end
end