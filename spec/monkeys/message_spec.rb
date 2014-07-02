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

    # Note: Non RFC Conformant
    # http://tools.ietf.org/html/rfc2822#section-3.5
    # Added to minimize behaviour differences with 2-4 stable, and to not break
    # rspec ./spec/mail/message_spec.rb:274 # Mail::Message accepting a plain text string email should give allow for whitespace on the gap line between header and body
    it 'allows 2 or more whitespaces on the gap line between header and body' do
      message = Mail::Message.new("To: foo\r\n  \r\nbody\r\n")
      message.decoded.should == 'body'
    end
  end
end
