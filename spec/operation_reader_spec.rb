require_relative '../lib/operation_reader'
require_relative '../lib/operation'

describe OperationReader do
  let(:subject) { described_class.new(path) }

  describe '#read' do
    let(:path) { 'spec/fixtures/test_operations.txt' }
    let(:operation) { double(Operation) }

    it 'sends the proper messages' do
      allow(Operation).to receive(:new).and_return(operation)
      allow(operation).to receive(:build!)

      subject.read

      expect(operation)
        .to have_received(:build!).exactly(3).times
    end
  end
end
