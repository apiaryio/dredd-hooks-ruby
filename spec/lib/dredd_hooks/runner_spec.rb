require 'spec_helper'

module DreddHooks
  describe Runner do

    let(:runner) { Runner.instance }

    describe 'exposes an interface to run hooks', protected: true do

      it { expect(runner).to respond_to :run_before_hooks_for_transaction }
      it { expect(runner).to respond_to :run_before_validation_hooks_for_transaction }
      it { expect(runner).to respond_to :run_after_hooks_for_transaction }
      it { expect(runner).to respond_to :run_before_each_hooks_for_transaction }
      it { expect(runner).to respond_to :run_before_each_validation_hooks_for_transaction }
      it { expect(runner).to respond_to :run_after_each_hooks_for_transaction }
      it { expect(runner).to respond_to :run_before_all_hooks_for_transaction }
      it { expect(runner).to respond_to :run_after_all_hooks_for_transaction }
    end

    describe 'exposes an interface to register hooks', private: true do

      it { expect(runner).to respond_to :register_before_hook }
      it { expect(runner).to respond_to :register_before_validation_hook }
      it { expect(runner).to respond_to :register_after_hook }
      it { expect(runner).to respond_to :register_before_each_hook }
      it { expect(runner).to respond_to :register_before_each_validation_hook }
      it { expect(runner).to respond_to :register_after_each_hook }
      it { expect(runner).to respond_to :register_before_all_hook }
      it { expect(runner).to respond_to :register_after_all_hook }
    end
  end
end

