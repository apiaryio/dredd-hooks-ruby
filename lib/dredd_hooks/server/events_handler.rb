require 'dredd_hooks/definitions'
require 'dredd_hooks/errors'
require 'dredd_hooks/runner'

module DreddHooks

  class Server
    class EventsHandler

      attr_reader :events, :runner
      private :events, :runner

      def initialize(events=EVENTS, runner=Runner.instance)
        @events = events
        @runner = runner
      end

      def handle(event, transaction)

         events.fetch(event.to_sym, []).each do |hook_name|
         begin
           transaction = runner.send("run_#{hook_name}_hooks_for_transaction", transaction)
          rescue NoMethodError
            raise UnknownHookError.new(hook_name)
          end
        end

        transaction
      end
    end
  end
end

