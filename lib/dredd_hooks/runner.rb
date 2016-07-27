require 'singleton'

require 'dredd_hooks/definitions'

module DreddHooks

  # The Ruby hooks runner stores and runs the Ruby hooks
  #
  # It provides registration methods to be used from the DSL,
  # as well as methods to run hooks by name from the server.
  #
  # All these methods are generated automatically according
  # to the hooks definitions.
  #
  # Note that this class is a Singleton. Use Runner.instance to
  # get references to its unique instance.
  class Runner

    include Singleton

    # Define registration methods in the form of:
    #
    #     def register_before_hook(transction_name, &block)
    #       hooks = @before_hooks || {}
    #       transaction_hooks = hooks.fetch(transaction_name, [])
    #       transaction_hooks.push(block)
    #       hooks[transaction_name] = transaction_hooks
    #       @before_hooks = hooks
    #     end
    #
    # Hooks names are defined by HOOKS_ON_SINGLE_TRANSACTIONS.
    #
    # Returns nothing.
    def self.define_registration_methods_for_hooks_on_single_transactions
      HOOKS_ON_SINGLE_TRANSACTIONS.each do |hook_name|

        define_method "register_#{hook_name}_hook" do |transaction_name, &block|
          hooks = instance_variable_get("@#{hook_name}_hooks") || {}
          transaction_hooks = hooks.fetch(transaction_name, [])
          transaction_hooks.push(block)
          hooks[transaction_name] = transaction_hooks
          instance_variable_set("@#{hook_name}_hooks", hooks)
        end

      end
    end
    private_class_method :define_registration_methods_for_hooks_on_single_transactions

    # Define registration methods in the form of:
    #
    #     def register_before_all_hook(&block)
    #       hooks = @before_hooks || []
    #       hooks.push(block)
    #       @before_all_hooks = hooks
    #     end
    #
    # Hooks names are defined by HOOKS_ON_MULTIPLE_TRANSACTIONS.
    #
    # Returns nothing.
    def self.define_registration_methods_for_hooks_on_multiple_transactions
      HOOKS_ON_MULTIPLE_TRANSACTIONS.each do |hook_name|

        define_method "register_#{hook_name}_hook" do |&block|
          hooks = instance_variable_get("@#{hook_name}_hooks") || []
          hooks.push(block)
          instance_variable_set("@#{hook_name}_hooks", hooks)
        end

      end
    end
    private_class_method :define_registration_methods_for_hooks_on_multiple_transactions

    # Define runner methods in the form of:
    #
    #     def run_before_hooks_for_transaction(transaction)
    #       hooks = @before_hooks || {}
    #       transaction_name = transaction['name']
    #       transaction_hooks = hooks.fetch(transaction_name, [])
    #       transaction_hooks.each do |hook|
    #         hook.call(transaction)
    #       end
    #       return transaction
    #     end
    #
    # Hooks names are defined by HOOKS_ON_SINGLE_TRANSACTIONS.
    #
    # Returns nothing.
    def self.define_runners_for_hooks_on_single_transactions
      HOOKS_ON_SINGLE_TRANSACTIONS.each do |hook_name|

        define_method "run_#{hook_name}_hooks_for_transaction" do |transaction|
          hooks = instance_variable_get("@#{hook_name}_hooks") || {}
          transaction_name = transaction['name']
          transaction_hooks = hooks.fetch(transaction_name, [])
          transaction_hooks.each do |hook|
            hook.call(transaction)
          end
          return transaction
        end

      end
    end
    private_class_method :define_runners_for_hooks_on_single_transactions

    # Define runner methods in the form of:
    #
    #     def run_before_all_hooks_for_transaction(transaction)
    #       hooks = @before_all_hooks || []
    #       hooks.each do |hook|
    #         hook.call(transaction)
    #       end
    #       return transaction
    #     end
    #
    # Hooks names are defined by HOOKS_ON_MULTIPLE_TRANSACTIONS.
    #
    # Returns nothing.
    def self.define_runners_for_hooks_on_multiple_transactions
      HOOKS_ON_MULTIPLE_TRANSACTIONS.each do |hook_name|

        define_method "run_#{hook_name}_hooks_for_transaction" do |transaction|
          hooks = instance_variable_get("@#{hook_name}_hooks") || []
          hooks.each do |hook|
            hook.call(transaction)
          end
          return transaction
        end

      end
    end
    private_class_method :define_runners_for_hooks_on_multiple_transactions

    define_registration_methods_for_hooks_on_single_transactions
    define_registration_methods_for_hooks_on_multiple_transactions

    define_runners_for_hooks_on_single_transactions
    define_runners_for_hooks_on_multiple_transactions

  end
end

