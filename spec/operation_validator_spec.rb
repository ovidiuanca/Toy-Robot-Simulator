require_relative '../lib/operation_validator'
require_relative '../lib/errors/errors'

RSpec.shared_examples 'valid operation' do |operation|
  let(:operation) { operation }

  it 'returns the operation' do
    expect(subject.validate!).to eq(operation)
  end
end

RSpec.shared_examples 'invalid operation' do |operation|
  let(:operation) { operation }

  it 'raises exception' do
    expect { subject.validate! }.to raise_error(NotValidOperationError)
  end
end

describe OperationValidator do
  let(:subject) { described_class.new(operation) }

  describe '#validate!' do
    context 'when operation is valid' do
      context 'when operation is MOVE' do
        include_examples 'valid operation', 'MOVE'
      end

      context 'when operation is LEFT' do
        include_examples 'valid operation', 'LEFT'
      end

      context 'when operation is RIGHT' do
        include_examples 'valid operation', 'RIGHT'
      end

      context 'when operation is REPORT' do
        include_examples 'valid operation', 'REPORT'
      end
    end

    context 'when operation is invalid' do
      context 'when operation is WRONG' do
        include_examples 'invalid operation', 'WRONG'
      end

      context 'when operation is SOUTH' do
        include_examples 'invalid operation', 'SOUTH'
      end

      context 'when operation is nil' do
        include_examples 'invalid operation', nil
      end

      context 'when operation is empty string' do
        include_examples 'invalid operation', ''
      end

      context 'when operation is looking has 3 parts but not a PLACE operation' do
        include_examples 'invalid operation', 'MOVE 1,1,SOUTH'
      end
    end

    context 'when operation is PLACE' do
      context 'when operation is valid' do
        context 'when operation is PLACE 0,0,SOUTH' do
          include_examples 'valid operation', 'PLACE 0,0,SOUTH'
        end

        context 'when operation is PLACE 0,0,NORTH' do
          include_examples 'valid operation', 'PLACE 0,0,NORTH'
        end

        context 'when operation is PLACE 0,0,EAST' do
          include_examples 'valid operation', 'PLACE 0,0,EAST'
        end

        context 'when operation is PLACE 0,0,WEST' do
          include_examples 'valid operation', 'PLACE 0,0,WEST'
        end

        context 'when operation is PLACE 4,4,NORTH' do
          include_examples 'valid operation', 'PLACE 4,4,NORTH'
        end
      end

      context 'when operation is invalid' do
        context 'when operation is PLACE' do
          include_examples 'invalid operation', 'PLACE'
        end

        context 'when operation is PLACE 0,SOUTH' do
          include_examples 'invalid operation', 'PLACE 0,SOUTH'
        end

        context 'when operation is PLACE 0,0,INVALID' do
          include_examples 'invalid operation', 'PLACE 0,0,INVALID'
        end

        context 'when operation is PLACE a,0,SOUTH' do
          include_examples 'invalid operation', 'PLACE a,0,SOUTH'
        end
      end
    end
  end
end
