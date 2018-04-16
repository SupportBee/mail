require 'spec_helper'

describe Mail::Message do
  describe 'Splitting headers and body' do
    it "doesn't split the message at an empty folded header" do
      message = Mail::Message.new("To: foo\r\n \r\nFrom: bar\r\n\r\nbody\r\n")
      message.decoded.should == "body\n"
    end

    # Borrowed from https://github.com/mikel/mail/commit/a2a45597bce66ebe788cedaaab848a37bd04b25a
    it 'splits only once if there are multiple \r\n\r\n in the body' do
      message = Mail::Message.new("To: Example <example@cirw.in>\r\n\r\nHello\r\n\r\nthere\r\n")
      message.decoded.should == "Hello\n\nthere\n"
    end

    it "should use QP transfer encoding for 7bit text with lines longer than 998 octets" do
      body = "a" * 999
      mail = Mail.new
      mail.charset = "UTF-8"
      mail.body = body
      mail.to_s.should =~ %r{Content-Transfer-Encoding: quoted-printable}
    end
  end
end
