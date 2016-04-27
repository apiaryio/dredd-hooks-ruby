require 'singleton'

module DreddHooks
  class Runner

    include Singleton

    HOOKS_ON_SINGLE_TRANSACTIONS = [:before, :before_validation, :after]
    HOOKS_ON_MULTIPLE_TRANSACTIONS = [:before_each, :before_each_validation,
                                      :after_each, :before_all, :after_all]

    def self.define_hooks_on_single_transactions
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
    private_class_method :define_hooks_on_single_transactions

    def self.define_hooks_on_multiple_transactions
      HOOKS_ON_MULTIPLE_TRANSACTIONS.each do |hook_name|
        define_method "register_#{hook_name}_hook" do |&block|
          hooks = instance_variable_get("@#{hook_name}_hooks") || []
          hooks.push(block)
          instance_variable_set("@#{hook_name}_hooks", hooks)
        end
      end
    end
    private_class_method :define_hooks_on_multiple_transactions

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

    define_hooks_on_single_transactions
    define_hooks_on_multiple_transactions

    define_runners_for_hooks_on_multiple_transactions

    #
    # Runers for Transaction specific hooks
    #

    def run_before_hooks_for_transaction(transaction)
      hooks =  @before_hooks || {}
      transaction_name = transaction["name"]
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_before_validation_hooks_for_transaction(transaction)
      hooks =  @before_validation_hooks || {}
      transaction_name = transaction["name"]
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_after_hooks_for_transaction(transaction)
      hooks =  @after_hooks || {}
      transaction_name = transaction["name"]
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end
  end
end

