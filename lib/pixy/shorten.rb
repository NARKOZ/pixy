module Pixy
  class Shorten
    attr_accessor :status, :long_url, :short_url, :counter

    def initialize(key, url)
      uri       = URI('http://p.tl/api/api_simple.php')
      uri.query = URI.encode_www_form({:key => key, :url => url})
      response  = Net::HTTP.get_response(uri)
      result    = JSON.parse(response.body)

      if response.code.to_i == 200
        self.status     = result['status']
        self.long_url   = result['long_url']
        self.short_url  = result['short_url']
        self.counter    = result['counter']
        raise_exception self.status unless self.status == 'ok'
      else
        raise "Server responded with code #{response.code}"
      end
    end

    private

    def raise_exception(status)
      case status
      when 'empty long url'
        raise EmptyLongUrl, "Missing long URL."
      when 'empty API key'
        raise EmptyApiKey, "Missing API key."
      when 'API limit'
        raise ApiLimit, "API limit exceeded."
      when 'invalid API key'
        raise InvalidApiKey, "API key is invalid."
      when 'invalid long url'
        raise InvalidLongUrl, "The URL can not be shortened."
      else
        raise UnknownError, "Unknown status error."
      end
    end
  end
end
