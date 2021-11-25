# frozen_string_literal: true

require_relative '../lib/operation'
require_relative '../lib/operation_validator'

describe Operation do
  let(:subject) { described_class.new(input) }

  describe '#validate!' do
    let(:input) { 'PLACE 1,1,NORTH' }

    it 'sends the proper message' do
      expect_any_instance_of(OperationValidator).to receive(:validate!)

      subject.validate!
    end
  end

  describe '#build!' do
    context 'when input is a PLACE operation' do
      let(:input) { 'PLACE 1,1,NORTH' }

      it 'sends the proper message' do
        subject.build!

        expect(subject.type).to eq('PLACE')
        expect(subject.x).to eq(1)
        expect(subject.y).to eq(1)
        expect(subject.direction).to eq('NORTH')
      end
    end

    context 'when input is a MOVE operation' do
      let(:input) { 'MOVE' }

      it 'sends the proper message' do
        subject.build!

        expect(subject.type).to eq('MOVE')
      end
    end

    context 'when input is a RIGHT operation' do
      let(:input) { 'RIGHT' }

      it 'sends the proper message' do
        subject.build!

        expect(subject.type).to eq('RIGHT')
      end
    end

    context 'when input is a LEFT operation' do
      let(:input) { 'LEFT' }

      it 'sends the proper message' do
        subject.build!

        expect(subject.type).to eq('LEFT')
      end
    end
  end
end
