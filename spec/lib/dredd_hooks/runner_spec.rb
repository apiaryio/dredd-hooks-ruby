require 'spec_helper'

module DreddHooks
  describe Runner, protected: true do

    let(:runner) { Runner.new }

    it { expect(runner).to respond_to :run_before_hooks_for_transaction }
    it { expect(runner).to respond_to :run_before_validation_hooks_for_transaction }
    it { expect(runner).to respond_to :run_after_hooks_for_transaction }
    it { expect(runner).to respond_to :run_before_each_hooks_for_transaction }
    it { expect(runner).to respond_to :run_before_each_validation_hooks_for_transaction }
    it { expect(runner).to respond_to :run_after_each_hooks_for_transaction }
    it { expect(runner).to respond_to :run_before_all_hooks_for_transaction }
    it { expect(runner).to respond_to :run_after_all_hooks_for_transaction }
  end
end

