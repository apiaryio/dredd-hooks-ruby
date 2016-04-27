require 'singleton'

module DreddHooks
  class Runner

    include Singleton

    HOOKS_ON_SINGLE_TRANSACTIONS = [:before, :before_validation, :after]

    def self.define_hooks_on_single_transactions
      HOOKS_ON_SINGLE_TRANSACTIONS.each do |hook_name|
        define_method "register_#{hook_name}_hook" do |transaction_name, &block|
          hooks = instance_variable_get("@#{hook_name}_hooks")
          transaction_hooks = hooks.fetch(transaction_name, [])
          transaction_hooks.push(block)
          hooks[transaction_name] = transaction_hooks
          instance_variable_set("@#{hook_name}_hooks", hooks)
        end
      end
    end
    private_class_method :define_hooks_on_single_transactions

    define_hooks_on_single_transactions

    def initialize
      @before_hooks = {}
      @before_validation_hooks = {}
      @after_hooks = {}

      @before_each_hooks = []
      @before_each_validation_hooks = []
      @after_each_hooks = []

      @before_all_hooks = []
      @after_all_hooks = []
    end

    def register_before_each_hook(&block)
      hooks = @before_each_hooks
      hooks.push(block)
      @before_each_hooks = hooks
    end

    def register_before_each_validation_hook(&block)
      hooks = @before_each_validation_hooks
      hooks.push(block)
      @before_each_validation_hooks = hooks
    end

    def register_after_each_hook(&block)
      hooks = @after_each_hooks
      hooks.push(block)
      @after_each_hooks = hooks
    end

    def register_before_all_hook(&block)
      hooks = @before_all_hooks
      hooks.push(block)
      @before_all_hooks = hooks
    end

    def register_after_all_hook(&block)
      hooks = @after_all_hooks
      hooks.push(block)
      @after_all_hooks = hooks
    end

    #
    # Runers for Transaction specific hooks
    #

    def run_before_hooks_for_transaction(transaction)
      hooks =  @before_hooks
      transaction_name = transaction["name"]
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_before_validation_hooks_for_transaction(transaction)
      hooks =  @before_validation_hooks
      transaction_name = transaction["name"]
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_after_hooks_for_transaction(transaction)
      hooks =  @after_hooks
      transaction_name = transaction["name"]
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    #
    # Runners for *_each hooks API
    #

    def run_before_each_hooks_for_transaction(transaction)
      hooks = @before_each_hooks
      hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_before_each_validation_hooks_for_transaction(transaction)
      hooks = @before_each_validation_hooks
      hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_after_each_hooks_for_transaction(transaction)
      hooks = @after_each_hooks
      hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    #
    # Runners for *_all hooks API
    #

    def run_before_all_hooks_for_transaction(transaction)
      hooks = @before_all_hooks
      hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_after_all_hooks_for_transaction(transaction)
      hooks = @after_all_hooks
      hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end
  end
end

