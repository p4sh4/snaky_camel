module SnakyCamel
  module Exception
    class BadResponseFormat < StandardError
      def initialize(message = nil)
        if message
          @message = "Badly formed JSON response: #{message}"
        else
          @message = "Badly formed JSON response, check its format"
        end
      end

      def to_s
        @message
      end
    end
  end
end