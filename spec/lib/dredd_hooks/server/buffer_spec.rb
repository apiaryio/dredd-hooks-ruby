require 'spec_helper'

module DreddHooks
  describe Server::Buffer, private: true do

    let(:message_delimiter) { "\t" }
    let(:buffer) { described_class.new(message_delimiter) }

    it { expect(buffer).to respond_to :<< }
    it { expect(buffer).to respond_to :flush! }
    it { expect(buffer).to respond_to :unshift_messages }
    it { expect(buffer).to respond_to :any_message? }

    it 'is empty by default' do
      expect(buffer.any_message?).to be false
    end

    describe '#any_message?' do

      it { expect(buffer.any_message?).to be false }

      context "when the buffer contains part of a message" do

        it {
          buffer << '{ "note": "This string contains no message delimiter..." }'
          expect(buffer.any_message?).to be false
        }
      end

      context "when the buffer contains at least one message" do

        it {
          buffer << "{ \"note\": \"This string does contain a message delimiter...\" }\t{ \"and\": \"some\", \"more\": \"stuff which is not even valid JSON.... aAAAah! "
          expect(buffer.any_message?).to be true
        }
      end
    end

    describe '#unshift_messages' do

      before(:each) do
        buffer << "{ \"A\": \"JSON message\" }\t"
        buffer << "{ \"another\": \"message\" }\t{ \"and a\": \"half\","
      end

      it 'returns an array of messages' do
        expect(buffer.unshift_messages).to eq [{ 'A' => 'JSON message' }, { 'another' => 'message' }]
      end

      it 'keeps the uncomplete messages intact' do
        buffer.unshift_messages
        expect(buffer.flush!).to eq '{ "and a": "half",'
      end
    end

  end
end

