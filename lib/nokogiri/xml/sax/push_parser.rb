module Nokogiri
  module XML
    module SAX
      ###
      # PushParser can parse a document that is fed to it manually.  It
      # must be given a SAX::Document object which will be called with
      # SAX events as the document is being parsed.
      #
      # Calling PushParser#<< writes XML to the parser, calling any SAX
      # callbacks it can.
      #
      # PushParser#finish tells the parser that the document is finished
      # and calls the end_document SAX method.
      #
      # Example:
      #
      #   parser = PushParser.new(Class.new(XML::SAX::Document) {
      #     def start_document
      #       puts "start document called"
      #     end
      #   }.new)
      #   parser << "<div>hello<"
      #   parser << "/div>"
      #   parser.finish
      class PushParser
        attr_accessor :document

        def initialize(doc = XML::SAX::Document.new, file_name = nil)
          @document = doc
          @sax_parser = XML::SAX::Parser.new(doc)

          ## Create our push parser context
          initialize_native(@sax_parser, file_name)
        end

        def write chunk, last_chunk = false
          native_write(chunk, last_chunk)
        end
        alias :<< :write

        def finish
          write '', true
        end
      end
    end
  end
end