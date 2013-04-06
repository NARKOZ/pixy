require 'pixy/version'
require 'pixy/shorten'
require 'pixy/errors'
require 'net/http'
require 'multi_json'

module Pixy
  def self.shorten(key=nil, url='')
    raise MissingApiKey, "API key is required" if key.nil?
    Shorten.new(key, url)
  end

  def self.shorten!(key=nil, url='')
    shorten(key, url).short_url
  end

  def self.stats(key=nil, url='^')
    pixy = shorten(key, url) # submit fake url to get API rate limit
    { :calls => pixy.counter, :limit => 1000 - pixy.counter }
  end
end
