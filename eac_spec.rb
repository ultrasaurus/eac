require './eac'

describe EAC do
  it "reads file" do
    pending "non-person file"
    File.open("./data/sia_walcott.xml") do |f|
      eac = EAC(f)
      eac.class.should eq(EAC::Doc)
    end
  end

  context "with invalid data" do
    it "needs entityType" do
      expect {
        EAC('<xml><eac-cpf xmlns="urn:isbn:1-931666-33-4"></eac></xml>')
      }.to raise_error(ArgumentError, "entityType not found")
    end
  end
  
  context "Doc create" do
    it "reads file" do
      File.open("./data/sia_walcott.xml") do |f|
        eac = EAC::Doc.new(f)
        eac.class.should eq(EAC::Doc)
      end
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
    it "generates EAC::Person class" do
        person.class.should eq(EAC::Person)    
    end

    describe "with name" do
      it "finds all names" do
        person.names.length.should == 5
      end

      describe "parts" do
        it "parses one" do
          person.names.first.parts.length == 1
        end
        it "handles multiple" do
          person.names[1].parts.length == 3
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
