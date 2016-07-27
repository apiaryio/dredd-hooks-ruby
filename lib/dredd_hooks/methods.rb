require 'dredd_hooks/definitions'
require 'dredd_hooks/runner'

module DreddHooks

  # The Ruby hooks API
  module Methods

    # Define hook methods in the form of:
    #
    #     def before(transaction_name, &block)
    #       runner.register_before_hook(transaction_name, &block)
    #     end
    #
    # Hooks names are defined by HOOKS_ON_SINGLE_TRANSACTIONS.
    #
    # Returns nothing.
    def self.define_hooks_on_single_transactions
      HOOKS_ON_SINGLE_TRANSACTIONS.each do |hook_name|

        define_method hook_name do |transaction_name, &block|
          runner.send("register_#{hook_name}_hook", transaction_name, &block)
        end

      end
    end
    private_class_method :define_hooks_on_single_transactions

    # Define hook methods in the form of:
    #
    #     def before_all(&block)
    #       runner.register_before_all_hook(&block)
    #     end
    #
    # Hooks names are defined by HOOKS_ON_MULTIPLE_TRANSACTIONS.
    #
    # Returns nothing.
    def self.define_hooks_on_multiple_transactions
      HOOKS_ON_MULTIPLE_TRANSACTIONS.each do |hook_name|

        define_method hook_name do |&block|
          runner.send("register_#{hook_name}_hook", &block)
        end

      end
    end
    private_class_method :define_hooks_on_multiple_transactions

    define_hooks_on_single_transactions
    define_hooks_on_multiple_transactions

    private

      def runner
        Runner.instance
      end
  end
end

