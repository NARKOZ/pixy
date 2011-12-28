require 'rspec'
require 'fakeweb'
require 'pixy'

FakeWeb.allow_net_connect = false

def escape_url(url)
  URI.encode_www_form_component(url).gsub('+', '%20')
end

API_URL                 = 'http://p.tl/api/api_simple.php'
url_to_shorten          = escape_url escape_url("https://github.com/narkoz/pixy")
invalid_url_to_shorten  = escape_url escape_url("^_^")

def load_fixture(name)
  File.open(File.dirname(__FILE__) + "/fixtures/#{name}.json").read
end

def fake_url(url, fixture_name)
  FakeWeb.register_uri(:get, url, :body => load_fixture(fixture_name))
end

fake_url "#{API_URL}?key=API_KEY&url=#{url_to_shorten}", 'ok'
fake_url "#{API_URL}?key=API_KEY&url=", 'empty_long_url'
fake_url "#{API_URL}?key=&url=#{url_to_shorten}", 'empty_api_key'
fake_url "#{API_URL}?key=invalid_API_KEY&url=#{url_to_shorten}", 'invalid_api_key'
fake_url "#{API_URL}?key=API_KEY&url=#{invalid_url_to_shorten}", 'invalid_long_url'
