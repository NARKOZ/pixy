module Pixy
  class EmptyLongUrl < StandardError; end
  class EmptyApiKey < StandardError; end
  class ApiLimit < StandardError; end
  class InvalidApiKey < StandardError; end
  class InvalidLongUrl < StandardError; end
  class UnknownError < StandardError; end
  class MissingApiKey < ArgumentError; end
end
