require 'dredd_hooks/runner'

module DreddHooks

  # The Ruby hooks API
  module Methods

    def before(transaction_name, &block)
      runner.register_before_hook(transaction_name, &block)
    end

    def before_validation(transaction_name, &block)
      runner.register_before_validation_hook(transaction_name, &block)
    end

    def after(transaction_name, &block)
      runner.register_after_hook(transaction_name, &block)
    end

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

