
require 'nokogiri'

module EAC
  
  class << self
    def parse(content)
      xml_doc = Nokogiri::XML(content)
      namespaces = xml_doc.collect_namespaces
      entity_types = xml_doc.xpath("//ns:cpfDescription/ns:identity/ns:entityType", 
                                   ns:namespaces['xmlns'])
      if entity_types.nil? || entity_types.length < 1                             
        raise ArgumentError.new("entityType not found")
      end
      if entity_types.length > 1
        puts "unexpected multiple entity types:#{entity_types.length} (choosing first)"
      end
      type = entity_types[0].text
      entity = case type
        when "person"
          Person.new(xml_doc)
        else
          Doc.new(xml_doc)
      end
    end
  end

  class Doc
    def initialize(xml_doc)
      @xml = xml_doc  
    end
  end

  class Person < Doc

  end

end

def EAC(*args, &block)
  EAC.parse(*args)
end

