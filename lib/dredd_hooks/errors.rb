module DreddHooks

  class UnknownHookError < RuntimeError

    def initialize(hook_name)
      @hook_name = hook_name
    end

    def to_s
      "Unknown hook: #{@hook_name}"
    end
  end

end

