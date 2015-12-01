module Mail
  class Message

    HEADER_SEPARATOR = /#{CRLF}#{CRLF}|#{CRLF}#{WSP}{2,}#{CRLF}(?!#{WSP})/m

  end
end
