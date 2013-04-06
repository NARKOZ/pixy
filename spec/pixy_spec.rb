require 'spec_helper'

describe Pixy do
  it { should respond_to :shorten }
  it { should respond_to :shorten! }
  it { should respond_to :stats }

  describe "#shorten" do
    context "without arguments" do
      it "should raise a required API key error" do
        expect { Pixy.shorten }.to raise_error(Pixy::MissingApiKey, "API key is required")
      end
    end

    context "with arguments" do
      it "should return an instance of Pixy::Shorten" do
        pixy = Pixy.shorten('API_KEY', 'https://github.com/narkoz/pixy')
        pixy.should be_a_kind_of Pixy::Shorten
      end
    end
  end

  describe "#shorten!" do
    it "should return a short url" do
      Pixy.shorten!('API_KEY', 'https://github.com/narkoz/pixy').should == 'http://p.tl/Us9R'
    end
  end
end
