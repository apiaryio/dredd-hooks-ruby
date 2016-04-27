require 'dredd_hooks/definitions'
require 'dredd_hooks/runner'

module DreddHooks

  # The Ruby hooks API
  module Methods

    def self.define_hooks_on_single_transactions
      HOOKS_ON_SINGLE_TRANSACTIONS.each do |hook_name|

        define_method hook_name do |transaction_name, &block|
          runner.send("register_#{hook_name}_hook", transaction_name, &block)
        end

      end
    end
    private_class_method :define_hooks_on_single_transactions

    define_hooks_on_single_transactions

    def before_each(&block)
      runner.register_before_each_hook(&block)
    end

    def before_each_validation(&block)
      runner.register_before_each_validation_hook(&block)
    end

    def after_each(&block)
      runner.register_after_each_hook(&block)
    end

    def before_all(&block)
      runner.register_before_all_hook(&block)
    end

    def after_all(&block)
      runner.register_after_all_hook(&block)
    end

    private

      def runner
        Runner.instance
      end
  end
end

