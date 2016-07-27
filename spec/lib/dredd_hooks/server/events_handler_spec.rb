require 'spec_helper'

# Runs the 'known' hook but not the 'unknown' one.
class DummyRunner

  def run_known_hooks_for_transaction(transaction)
    transaction
  end
end

module DreddHooks
  describe Server::EventsHandler, private: true do

    let(:events_handler) { described_class.new }

    it { expect(events_handler).to respond_to :handle }

    describe '#handle' do

      it 'returns a transaction' do
       event = 'doNothing'
       transaction = double()
       expect(events_handler.handle(event, transaction)).to eq transaction
      end

      context 'when attempting to handle a hook not defined by the DSL' do

        let(:events_definition) {
          {
            beforeAll: [
              :known,
            ],
            afterAll: [
              :unknown
            ]
          }
        }
        let(:transaction) { double }
        let(:runner) { DummyRunner.new }
        let(:events_handler) { described_class.new(events_definition, runner) }

        it 'raises a UnknownHookError' do
          expect{ events_handler.handle('beforeAll', transaction) }.not_to raise_error
          expect{ events_handler.handle('afterAll', transaction) }.to raise_error UnknownHookError
        end
      end
    end
  end
end

