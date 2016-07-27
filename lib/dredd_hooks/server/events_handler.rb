require 'dredd_hooks/runner'

module DreddHooks
  class Server
    class EventsHandler

      attr_reader :runner
      private :runner

      def initialize
        @runner = Runner.instance
      end

      def handle(event, transaction)

        if event == "beforeEach"
          transaction = runner.run_before_each_hooks_for_transaction(transaction)
          transaction = runner.run_before_hooks_for_transaction(transaction)
        end

        if event == "beforeEachValidation"
          transaction = runner.run_before_each_validation_hooks_for_transaction(transaction)
          transaction = runner.run_before_validation_hooks_for_transaction(transaction)
        end

        if event == "afterEach"
          transaction = runner.run_after_hooks_for_transaction(transaction)
          transaction = runner.run_after_each_hooks_for_transaction(transaction)
        end

        if event == "beforeAll"
          transaction = runner.run_before_all_hooks_for_transaction(transaction)
        end

        if event == "afterAll"
          transaction = runner.run_after_all_hooks_for_transaction(transaction)
        end

        transaction
      end
    end
  end
end

