require 'pixy/version'
require 'pixy/shorten'
require 'pixy/errors'
require 'net/http'
require 'json'

module Pixy
  extend self

  def shorten(key=nil, url='')
    raise MissingApiKey, "API key is required" if key.nil?
    Pixy::Shorten.new(key, url)
  end

  def shorten!(key=nil, url='')
    Pixy.shorten(key, url).short_url
  end

  def stats(key=nil, url='^')
    pixy = Pixy.shorten(key, url)
    {
      :calls => pixy.counter,
      :limit => 1000 - pixy.counter
    }
  end
end
