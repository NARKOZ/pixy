require 'pixy/version'
require 'pixy/shorten'
require 'net/http'
require 'json'

module Pixy
  extend self

  def shorten!(key=nil, url='')
    raise ArgumentError, "API key is required" if key.nil?
    Pixy::Shorten.new(key, url)
  end
end
