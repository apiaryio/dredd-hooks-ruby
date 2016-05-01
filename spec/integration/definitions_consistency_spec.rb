require 'spec_helper'

module DreddHooks
  describe 'All the defined hooks', protected: true do

    DEFINED_HOOKS = HOOKS_ON_SINGLE_TRANSACTIONS + HOOKS_ON_MULTIPLE_TRANSACTIONS

    describe 'are runned on least one event' do

      let(:hooks_in_use) { Server::EVENTS.map{ |_event, hooks| hooks }.flatten.uniq }

      DEFINED_HOOKS.each do |hook_name|
        it ":#{hook_name} is refered to by at least one event" do
          expect(hooks_in_use).to include(hook_name)
        end
      end

    end
  end
  
  describe 'DreddHooks events definition', protected: true do

    describe 'only refers to hooks that are already defined' do

      let(:defined_hooks) { HOOKS_ON_SINGLE_TRANSACTIONS + HOOKS_ON_MULTIPLE_TRANSACTIONS }

      Server::EVENTS.each do |_event, hook_names|
        hook_names.each do |hook_name|
          it ":#{hook_name} is defined" do
            expect(defined_hooks).to include(hook_name)
          end
        end
      end

    end
  end
end

