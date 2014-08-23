require './lib/eac'

describe EAC do
  context "reads file" do
    it "using EAC shorcut" do
      eac = EAC(File.read("./data/sia_walcott.xml"))
      eac.should be_a(EAC::Person)
    end

    it "using EAC::Doc.new" do
      eac = EAC::Doc.new(File.read("./data/sia_walcott.xml"))
      eac.should be_a(EAC::Doc)
    end

  end

  context "with invalid data" do
    it "needs entityType" do
      expect {
        EAC('<xml><eac-cpf xmlns="urn:isbn:1-931666-33-4"></eac></xml>')
      }.to raise_error(ArgumentError, "entityType not found")
    end
  end

  context "Person create" do
    let(:person) do
      person = nil
      File.open("./data/sia_walcott.xml") do |f|
        person = EAC(f)
      end
      person
    end

    describe "attributes" do
      it "should have 'record_id'" do
        expect(person.record_id).to eq("RU007004")
      end
    end

    describe "with name" do
      it "finds all names" do
        person.names.length.should == 5
      end

      describe "parts" do
        it "handles a name entry with only one part" do
          single_part_name = person.names.first
          parts = single_part_name.parts
          expect(parts.length).to eq(1)
          expect(parts[0].local_type).to be_nil
          expect(parts[0].text).to eq("Walcott, Charles D. (Charles Doolittle), 1850-1927")
        end

        it "handles a name entry with multiple parts" do
          multipart_name = person.names[1]
          expect(multipart_name.parts.length).to eq(3)

          expect(multipart_name.parts[0].local_type).to eq("surname")
          expect(multipart_name.parts[0].text).to eq("Walcott")
        end
      end

      describe "reports full string" do
        it "of simple name" do
          person.names.first.to_s.should == "Walcott, Charles D. (Charles Doolittle), 1850-1927"
        end

        it "of name with multiple parts" do
          person.names[1].to_s.should == "Walcott, Charles D., 1850-1927"
        end
      end

    end
  end
end
