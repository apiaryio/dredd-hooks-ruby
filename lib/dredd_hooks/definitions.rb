module DreddHooks

    HOOKS_ON_SINGLE_TRANSACTIONS = [:before, :before_validation, :after]

    HOOKS_ON_MULTIPLE_TRANSACTIONS = [:before_each, :before_each_validation,
                                      :after_each, :before_all, :after_all]
end

