module Mail
  class ReceivedElement
    def initialize(string)
      parser = Mail::ReceivedParser.new
      unless tree = parser.parse(string)
        raise Mail::Field::ParseError.new(ReceivedElement, string, parser.failure_reason)
      end

      begin
        @date_time = ::DateTime.parse("#{tree.date_time.date.text_value} #{tree.date_time.time.text_value}")
      rescue ArgumentError => e
        @date_time = nil
      end
      @info = tree.name_val_list.text_value
    end
  end
end
