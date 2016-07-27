module DreddHooks

    HOOKS_ON_SINGLE_TRANSACTIONS = [:before, :before_validation, :after]

    HOOKS_ON_MULTIPLE_TRANSACTIONS = [:before_each, :before_each_validation,
                                      :after_each, :before_all, :after_all]

    Server::EVENTS = {
      beforeEach: [
        :before_each,
        :before,
      ],
      beforeEachValidation: [
        :before_each_validation,
        :before_validation,
      ],
      afterEach: [
        :after,
        :after_each,
      ],
      afterAll: [
        :after_all,
      ],
      beforeAll: [
        :before_all,
      ],
    }

end

