require 'spec_helper'

describe Mail::Message do
  describe 'splitting' do
    it "doesn't split the message at an empty folded header" do
      message = Mail::Message.new("To: foo\r\n \r\nFrom: bar\r\n\r\nbody\r\n")
      message.decoded.should == 'body'
    end

    # Borrowed from
    # https://github.com/mikel/mail/commit/a2a45597bce66ebe788cedaaab848a37bd04b25a
    it 'splits only once if there are "\r\n\r\n"s in the body' do
      message = Mail::Message.new("To: Example <example@cirw.in>\r\n\r\nHello\r\n\r\nthere\r\n")
      message.decoded.should == "Hello\n\nthere"
    end
  end
end
