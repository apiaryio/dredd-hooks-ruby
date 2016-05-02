require 'json'

module DreddHooks
  class Server

    # Store JSON messages or part of them
    class Buffer

      def initialize(message_delimiter)
        flush!
        @message_delimiter = message_delimiter
      end

      # Empty the buffer.
      #
      # Returns the buffer content String.
      def flush!
        content = @content
        @content = ""
        content
      end

      def <<(string)
        @content += string
      end

      def any_message?
        @content.include? @message_delimiter
      end

      def unshift_messages
        flush!.
        split(@message_delimiter).
        inject([]) { |messages, message|
          begin
            messages.push JSON.parse(message)
          rescue JSON::ParserError
            # If the message after the delimiter is not parseable JSON,
            # then it's a chunk of the next message, and should be put back
            # into the buffer.
            @content += message
            messages
          end
        }
      end

    end
  end
end
