require 'spec_helper'

describe Pixy::Shorten do
  it { Pixy.should respond_to :shorten }
  it { Pixy.should respond_to :shorten! }

  describe "#shorten!" do
    it "should return a short url" do
      Pixy.shorten!('API_KEY', 'https://github.com/narkoz/pixy').should == 'http://p.tl/Us9R'
    end
  end

  context "when a new short url requested" do
    context "without arguments" do
      it "should raise a required API key error" do
        lambda { Pixy.shorten }.should raise_error(Pixy::MissingApiKey, "API key is required")
      end
    end

    context "with arguments" do
      subject { Pixy.shorten('API_KEY', 'https://github.com/narkoz/pixy') }

      describe "#status" do
        it "should return a response status" do
          subject.status.should == 'ok'
        end
      end

      describe "#long_url" do
        it "should return a long url" do
          subject.long_url.should == 'https://github.com/narkoz/pixy'
        end
      end

      describe "#short_url" do
        it "should return a short url" do
          subject.short_url.should == 'http://p.tl/Us9R'
        end
      end

      describe "#counter" do
        it "should return a request number" do
          subject.counter.should == 12
        end
      end

      context "with empty long url" do
        it "should raise EmptyLongUrl" do
          lambda {
            Pixy.shorten('API_KEY', '')
          }.should raise_error(Pixy::EmptyLongUrl, "Missing long URL.")
        end
      end

      context "with empty API key" do
        it "should raise EmptyApiKey" do
          lambda {
            Pixy.shorten('', 'https://github.com/narkoz/pixy')
          }.should raise_error(Pixy::EmptyApiKey, "Missing API key.")
        end
      end

      context "with invalid API key" do
        it "should raise InvalidApiKey" do
          lambda {
            Pixy.shorten('invalid_API_KEY', 'https://github.com/narkoz/pixy')
          }.should raise_error(Pixy::InvalidApiKey, "API key is invalid.")
        end
      end

      context "with invalid long url" do
        it "should raise InvalidLongUrl" do
          lambda {
            Pixy.shorten('API_KEY', '^_^')
          }.should raise_error(Pixy::InvalidLongUrl, "The URL can not be shortened.")
        end
      end
    end
  end
end
