require 'dredd_hooks/errors'
require 'dredd_hooks/runner'

module DreddHooks

  class Server

    EVENTS = {
      beforeEach: [
        :before_each,
        :before,
      ],
      beforeEachValidation: [
        :before_each_validation,
        :before_validation,
      ],
      afterEach: [
        :after,
        :after_each,
      ],
      afterAll: [
        :after_all,
      ],
      beforeAll: [
        :before_all,
      ],
    }

    class EventsHandler

      attr_reader :events, :runner
      private :events, :runner

      def initialize(events=EVENTS, runner=Runner.instance)
        @events = events
        @runner = runner
      end

      def handle(event, transaction)

        begin
          events.fetch(event.to_sym).each do |hook_name|
            begin
              transaction = runner.send("run_#{hook_name}_hooks_for_transaction", transaction)
            rescue NoMethodError
              raise UnknownHookError.new(hook_name)
            end
          end
        rescue KeyError => error
        end

        transaction
      end
    end
  end
end

