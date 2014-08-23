
require 'nokogiri'

module EAC
  
  class << self
    def parse(content)
      xml_doc = Nokogiri::XML(content)
      entity_types = xml_doc.xpath("//ns:cpfDescription/ns:identity/ns:entityType", 
                                   ns:'urn:isbn:1-931666-33-4')
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
    def initialize(xml_doc)
      super
    end

    def names
      if @names.nil?
         @names = names_from_entries
      end
      @names
    end

    def names_from_entries
      name_elements = []
      name_entries = @xml.xpath("//ns:cpfDescription/ns:identity/ns:nameEntry",
                                    ns:'urn:isbn:1-931666-33-4')
      name_entries.each do |entry|
        name_elements << Name.new(entry)
      end
      name_elements
    end

    class Name
      attr_reader :parts

      def initialize(xml)
        @parts = []
        xml_parts = xml.xpath('ns:part', ns:'urn:isbn:1-931666-33-4')
        xml_parts.each do |part_data|
          @parts << Part.new(part_data)
        end
      end

      def to_s
        @parts.map(&:text).join(', ')
      end

      class Part
        attr_reader :local_type, :text

        def initialize(xml)
          @local_type = xml['localType']
          @text = xml.text
        end
      end

    end
  end

end

def EAC(*args, &block)
  EAC.parse(*args)
end

