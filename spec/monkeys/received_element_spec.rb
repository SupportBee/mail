require 'spec_helper'

describe Mail::ReceivedElement do
  context 'invalid date time in received field' do
    let(:string) { 'from dc1prrelay1.ga.adp.com ([11.0.5.21]) by dc1prppa2.ga.adp.com with ESMTP id 1jubhyndcn-1; Wed, 9 Apr 2014 14:77:74 GMT' }

    describe '#new' do
      it "doesn't raise error" do
        expect { Mail::ReceivedElement.new(string) }.to_not raise_error
      end
    end

    describe '#date_time' do
      let(:received_element) { Mail::ReceivedElement.new(string) }

      it 'returns nil' do
        received_element.date_time.should == nil
      end
    end
  end
end
