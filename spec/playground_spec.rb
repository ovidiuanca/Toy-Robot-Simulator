# frozen_string_literal: true

require_relative '../lib/playground'

describe Playground do
  describe '.initialize!' do
    context 'when PLACE is first operation' do
      let(:path) { 'spec/fixtures/test_operations.txt' }

      it 'creates the proper ojects' do
        playground = described_class.new(path)

        expect(playground.operations).not_to be_empty
      end
    end

    context 'when PLACE is NOT first operation' do
      let(:subject) { described_class.new(path) }
      let(:path) { 'spec/fixtures/place_not_first.txt' }

      it 'ignores the actions before PLACE and calls MOVE only 1 time' do
        expect_any_instance_of(Toy).to receive(:place).exactly(1).times
        expect_any_instance_of(Toy).to receive(:move).exactly(1).times
        expect_any_instance_of(Toy).to receive(:report).exactly(1).times

        subject.run
      end
    end
  end

  describe '#run' do
    let(:subject) { described_class.new(path) }
    let(:path) { 'spec/fixtures/test_operations.txt' }

    it 'sends the proper messages' do
      expect_any_instance_of(Toy).to receive(:place).exactly(1).times
      expect_any_instance_of(Toy).to receive(:move).exactly(1).times
      expect_any_instance_of(Toy).to receive(:report).exactly(1).times

      subject.run
    end
  end
end
