module Mail
  class Message
    def parse_message
      header_part, body_part = raw_source.lstrip.split(/#{CRLF}#{CRLF}|#{CRLF}#{WSP}{2,}#{CRLF}/m, 2)
      self.header = header_part
      self.body = body_part
    end
  end
end
