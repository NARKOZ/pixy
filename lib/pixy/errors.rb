module Pixy
  class Error < StandardError; end
  class EmptyLongUrl < Error; end
  class EmptyApiKey < Error; end
  class ApiLimit < Error; end
  class InvalidApiKey < Error; end
  class InvalidLongUrl < Error; end
  class UnknownError < Error; end
  class MissingApiKey < Error; end
end
