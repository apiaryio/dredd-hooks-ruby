require 'socket'

require 'dredd_hooks/server/buffer'
require 'dredd_hooks/server/events_handler'

module DreddHooks

  # The hooks worker server
  class Server

    attr_reader :buffer, :error, :events_handler, :out, :server
    private :buffer, :error, :events_handler, :out, :server

    HOST = '127.0.0.1'
    PORT = 61321
    MESSAGE_DELIMITER = "\n"

    def initialize(error=STDERR, out=STDOUT)
      @error = error
      @out = out
      @server = TCPServer.new(HOST, PORT)
      @buffer = Buffer.new(MESSAGE_DELIMITER)
      @events_handler = EventsHandler.new
    end

    def run
      disable_buffering(out)
      loop do
        client = server.accept
        out.puts 'Dredd connected to Ruby Dredd hooks worker'
        buffer.flush!
        while (data = client.recv(10))
          buffer << data
          if buffer.any_message?
            messages = buffer.unshift_messages

            messages.each do |message|
              response = process_message(message)
              client.puts response + MESSAGE_DELIMITER
            end
          end
        end
        client.close
      end
    end

    private

      # Write to a file (e.g. STDOUT) without delay
      #
      # See https://stackoverflow.com/q/23001033
      # and http://ruby-doc.org/core-2.3.1/IO.html#method-i-sync-3D
      def disable_buffering(file)
        file.sync = true
      end

      def process_message(message)
        event = message['event']
        transaction = message['data']

        transaction = events_handler.handle(event, transaction)

        response(message['uuid'], event, transaction)
      end

      def response(message_uuid, event, transaction)
        {
          uuid: message_uuid,
          event: event,
          data: transaction,
        }.to_json
      end

  end
end

