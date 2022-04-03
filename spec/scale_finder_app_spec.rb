require "./scale_finder"
require "./app"

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

# Following four tests are for the Scale class and its subclasses
describe Scale do
  it "creates an instance of scale class" do
  c = Scale.new("C")
  expect(c).to be_kind_of(Scale)
  end
end

# test to confirm the scale class creation and a test to confirm desired output of the method
describe MajorScale do
  it "returns scale based on root note" do
    c = MajorScale.new("C")
    expect(c).to be_kind_of(MajorScale)
    expect(c.major_scale[4]).to eq("G")
  end
end

describe HarmonicMinorScale do
  it "returns scale based on root note" do
    c = HarmonicMinorScale.new("C")
    expect(c).to be_kind_of(HarmonicMinorScale)
    expect(c.harmonic_minor_scale[5]).to eq("G#")
  end
end

describe BluesScale do
  it "returns scale based on root note" do
    c = BluesScale.new("C")
    expect(c).to be_kind_of(BluesScale)
    expect(c.blues_scale[3]).to eq("F#")
  end
end