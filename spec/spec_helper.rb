require 'rspec'
require 'fakeweb'
require 'pixy'

FakeWeb.allow_net_connect = false

url_to_shorten = "https%3A%2F%2Fgithub.com%2Fnarkoz%2Fpixy"
FakeWeb.register_uri(:get,
        "http://p.tl/api/api_simple.php?key=API_KEY&url=#{url_to_shorten}",
        :body => {
          :status     => 'ok',
          :long_url   => 'https://github.com/narkoz/pixy',
          :short_url  => 'http://p.tl/Us9R',
          :counter    => 12
        }.to_json)
