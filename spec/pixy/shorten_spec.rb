require 'spec_helper'

describe Pixy::Shorten do
  context "when a new short url requested" do
    it { Pixy.should respond_to(:shorten!) }

    context "without arguments" do
      it "should raise a required API key error" do
        lambda { Pixy.shorten! }.should raise_error(ArgumentError, "API key is required")
      end
    end

    context "with arguments" do
      subject { Pixy.shorten!('API_KEY', 'https://github.com/narkoz/pixy') }

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
    end
  end
end
