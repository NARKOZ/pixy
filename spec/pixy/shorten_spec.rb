require 'spec_helper'

describe Pixy::Shorten do
  let(:pixy) { Pixy::Shorten.new('API_KEY', 'https://github.com/narkoz/pixy') }

  describe "#status" do
    it "should return a response status" do
      pixy.status.should == 'ok'
    end
  end

  describe "#long_url" do
    it "should return a long url" do
      pixy.long_url.should == 'https://github.com/narkoz/pixy'
    end
  end

  describe "#short_url" do
    it "should return a short url" do
      pixy.short_url.should == 'http://p.tl/Us9R'
    end
  end

  describe "#counter" do
    it "should return a request number" do
      pixy.counter.should == 12
    end
  end

  describe "exceptions" do
    context "when empty long url" do
      it "should raise EmptyLongUrl" do
        expect {
          Pixy::Shorten.new('API_KEY', '')
        }.to raise_error(Pixy::EmptyLongUrl, "Missing long URL.")
      end
    end

    context "when empty API key" do
      it "should raise EmptyApiKey" do
        expect {
          Pixy::Shorten.new('', 'https://github.com/narkoz/pixy')
        }.to raise_error(Pixy::EmptyApiKey, "Missing API key.")
      end
    end

    context "when invalid API key" do
      it "should raise InvalidApiKey" do
        expect {
          Pixy::Shorten.new('invalid_API_KEY', 'https://github.com/narkoz/pixy')
        }.to raise_error(Pixy::InvalidApiKey, "API key is invalid.")
      end
    end

    context "when invalid long url" do
      it "should raise InvalidLongUrl" do
        expect {
          Pixy::Shorten.new('API_KEY', '^_^')
        }.to raise_error(Pixy::InvalidLongUrl, "The URL can not be shortened.")
      end
    end
  end
end
