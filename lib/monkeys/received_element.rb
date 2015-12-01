module Mail
  class ReceivedElement

    def initialize(string)
      parser = Mail::Parsers::ReceivedParser.new
      unless tree = parser.parse(string)
        raise Mail::Field::ParseError.new(Mail::ReceivedElement, string, parser.failure_reason)
      end

      begin
        @date_time = ::DateTime.parse("#{tree.date} #{tree.time}")
      rescue ArgumentError => e
        @date_time = nil
      end
      @info = tree.info
    end

  end
end
