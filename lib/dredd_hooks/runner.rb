require 'singleton'

module DreddHooks
  class Runner

    include Singleton

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

    def register_before_hook(transaction_name, &block)
      hooks = @before_hooks
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.push(block)
      hooks[transaction_name] = transaction_hooks
      @before_hooks = hooks
    end

    def register_before_validation_hook(transaction_name, &block)
      hooks = @before_validation_hooks
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.push(block)
      hooks[transaction_name] = transaction_hooks
      @before_validation_hooks = hooks
    end

    def register_after_hook(transaction_name, &block)
      hooks = @after_hooks
      transaction_hooks = hooks.fetch(transaction_name, [])
      transaction_hooks.push(block)
      hooks[transaction_name] = transaction_hooks
      @after_hooks = hooks
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
      transaction_name = transaction["name"]
      hooks = @before_hooks[transaction_name] || []
      hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_before_validation_hooks_for_transaction(transaction)
      transaction_name = transaction["name"]
      hooks = @before_validation_hooks[transaction_name] || []
      hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_after_hooks_for_transaction(transaction)
      transaction_name = transaction["name"]
      hooks = @after_hooks[transaction_name] || []
      hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    #
    # Runners for *_each hooks API
    #

    def run_before_each_hooks_for_transaction(transaction)
      @before_each_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_before_each_validation_hooks_for_transaction(transaction)
      @before_each_validation_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_after_each_hooks_for_transaction(transaction)
      @after_each_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    #
    # Runners for *_all hooks API
    #

    def run_before_all_hooks_for_transaction(transaction)
      @before_all_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end

    def run_after_all_hooks_for_transaction(transaction)
      @after_all_hooks.each do |hook_proc|
        hook_proc.call(transaction)
      end
      return transaction
    end
  end
end

