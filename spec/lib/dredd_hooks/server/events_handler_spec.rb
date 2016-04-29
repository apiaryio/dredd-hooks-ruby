require 'spec_helper'

module DreddHooks
  describe Server::EventsHandler, private: true do

   let(:events_handler) { described_class.new }

   it { expect(events_handler).to respond_to :handle }

   describe '#handle' do

     it 'returns a transaction' do
       event = 'do_nothing'
       transaction = double()
       expect(events_handler.handle(event, transaction)).to eq transaction
     end
   end
  end
end

