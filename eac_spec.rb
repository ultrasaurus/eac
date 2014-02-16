require './eac'

describe EAC do
  it "reads file" do
    pending "need non-person file"
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
  end

end
