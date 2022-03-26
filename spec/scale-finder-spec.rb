require "./scale-finder"

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
