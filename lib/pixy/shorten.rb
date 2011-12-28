module Pixy
  class Shorten
    API_URL = 'http://p.tl/api/api_simple.php'
    attr_accessor :status, :long_url, :short_url, :counter

    def initialize(key, url)
      uri       = URI "#{API_URL}?key=#{key}&url=#{escape_url escape_url(url)}"
      response  = Net::HTTP.get_response(uri)
      result    = JSON.parse(response.body)

      if response.code.to_i == 200
        @status     = result['status']
        @long_url   = result['long_url']
        @short_url  = result['short_url']
        @counter    = result['counter']
        raise_exception @status unless @status == 'ok'
      else
        raise UnknownError, "Server responded with code #{response.code}"
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

    def escape_url(url)
      URI.encode_www_form_component(url).gsub('+', '%20')
    end
  end
end
