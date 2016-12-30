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
          method_name = "run_#{hook_name}_hooks_for_transaction"
          if runner.respond_to?(method_name)
            transaction = runner.send(method_name, transaction)
          else
            raise UnknownHookError.new(hook_name)
          end
        end

        transaction
      end
    end
  end
end
