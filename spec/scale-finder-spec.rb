require "./scale-finder"

# app will show scales related to notes
describe NaturalNotes do
    describe ".add" do
        context "given empty string" do
            it "returns zero" do
                expect(NaturalNotes.add("")).to eq (0)
            end
        end
    end
end
