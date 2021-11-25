require_relative '../lib/map'
require_relative '../lib/toy'
require_relative '../lib/operation'
require_relative '../lib/errors/errors'

describe Toy do
  let(:subject) { described_class.new(map: map) }
  let(:map) { Map.new(width: 5, height: 5) }

  describe '#place' do
    context 'when PLACE is within the map' do
      let(:operation) { Operation.new('PLACE 1,2,NORTH') }

      before do
        operation.build!
      end

      it 'changes toy position properly' do
        subject.place(operation)

        expect(subject.current_x).to eq(1)
        expect(subject.current_y).to eq(2)
        expect(subject.direction).to eq('NORTH')
      end
    end

    context 'when PLACE is placed on 0,0' do
      let(:operation) { Operation.new('PLACE 0,0,SOUTH') }

      before do
        operation.build!
      end

      it 'changes toy position properly' do
        subject.place(operation)

        expect(subject.current_x).to eq(0)
        expect(subject.current_y).to eq(0)
        expect(subject.direction).to eq('SOUTH')
      end
    end

    context 'when PLACE is placed on the map high boundaries' do
      let(:operation) { Operation.new("PLACE #{map.width - 1},#{map.height - 1},SOUTH") }

      before do
        operation.build!
      end

      it 'changes toy position properly' do
        subject.place(operation)

        expect(subject.current_x).to eq(map.width - 1)
        expect(subject.current_y).to eq(map.height - 1)
        expect(subject.direction).to eq('SOUTH')
      end
    end

    context 'when PLACE is placed outside the map' do
      let(:operation) { Operation.new("PLACE #{map.width + 1},1,SOUTH") }

      before do
        operation.build!
      end

      it 'raises proper error' do
        expect { subject.place(operation) }
          .to raise_error(PlaceOutsideOfMapError)
      end
    end
  end

  describe '#move' do
    before do
        operation.build!
    end

    context 'when moving inside the map' do
      context 'when direction is NORTH' do
        let(:operation) { Operation.new('PLACE 1,1,NORTH') }

        it 'changes the toy position properly' do
          subject.place(operation) # placing the toy on the map first

          subject.move

          expect(subject.current_y).to eq(2)
          expect(subject.current_x).to eq(1)
          expect(subject.direction).to eq('NORTH')
        end
      end

      context 'when direction is SOUTH' do
        let(:operation) { Operation.new('PLACE 1,1,SOUTH') }

        it 'changes the toy position properly' do
          subject.place(operation)

          subject.move

          expect(subject.current_y).to eq(0)
          expect(subject.current_x).to eq(1)
          expect(subject.direction).to eq('SOUTH')
        end
      end

      context 'when direction is EAST' do
        let(:operation) { Operation.new('PLACE 1,1,EAST') }

        it 'changes the toy position properly' do
          subject.place(operation)

          subject.move

          expect(subject.current_y).to eq(1)
          expect(subject.current_x).to eq(2)
          expect(subject.direction).to eq('EAST')
        end
      end

      context 'when direction is WEST' do
        let(:operation) { Operation.new('PLACE 1,1,WEST') }

        it 'changes the toy position properly' do
          subject.place(operation)

          subject.move

          expect(subject.current_y).to eq(1)
          expect(subject.current_x).to eq(0)
          expect(subject.direction).to eq('WEST')
        end
      end
    end

    context 'when moving below the map' do
      let(:operation) { Operation.new('PLACE 0,0,SOUTH') }

      it 'does not change the toy position' do
        subject.place(operation)

        subject.move

        expect(subject.current_y).to eq(0)
        expect(subject.current_x).to eq(0)
        expect(subject.direction).to eq('SOUTH')
      end
    end

    context 'when moving above the map' do
      let(:operation) { Operation.new('PLACE 4,4,NORTH') }

      it 'does not change the toy position' do
        subject.place(operation)

        subject.move

        expect(subject.current_y).to eq(4)
        expect(subject.current_x).to eq(4)
        expect(subject.direction).to eq('NORTH')
      end
    end
  end

  describe '#right' do
    before do
      operation.build!
    end

    context 'when direction is NORTH' do
      let(:operation) { Operation.new("PLACE 1,1,NORTH") }

      it 'rotates correctly' do
        subject.place(operation)

        subject.right

        expect(subject.direction).to eq('EAST')
      end
    end

    context 'when direction is EAST' do
      let(:operation) { Operation.new("PLACE 1,1,EAST") }

      it 'rotates correctly' do
        subject.place(operation)

        subject.right

        expect(subject.direction).to eq('SOUTH')
      end
    end

    context 'when direction is SOUTH' do
      let(:operation) { Operation.new("PLACE 1,1,SOUTH") }

      it 'rotates correctly' do
        subject.place(operation)

        subject.right

        expect(subject.direction).to eq('WEST')
      end
    end

    context 'when direction is WEST' do
      let(:operation) { Operation.new("PLACE 1,1,WEST") }

      it 'rotates correctly' do
        subject.place(operation)

        subject.right

        expect(subject.direction).to eq('NORTH')
      end
    end
  end

  describe '#left' do
    before do
      operation.build!
    end

    context 'when direction is NORTH' do
      let(:operation) { Operation.new("PLACE 1,1,NORTH") }

      it 'rotates correctly' do
        subject.place(operation)

        subject.left

        expect(subject.direction).to eq('WEST')
      end
    end

    context 'when direction is EAST' do
      let(:operation) { Operation.new("PLACE 1,1,EAST") }

      it 'rotates correctly' do
        subject.place(operation)

        subject.left

        expect(subject.direction).to eq('NORTH')
      end
    end

    context 'when direction is SOUTH' do
      let(:operation) { Operation.new("PLACE 1,1,SOUTH") }

      it 'rotates correctly' do
        subject.place(operation)

        subject.left

        expect(subject.direction).to eq('EAST')
      end
    end

    context 'when direction is WEST' do
      let(:operation) { Operation.new("PLACE 1,1,WEST") }

      it 'rotates correctly' do
        subject.place(operation)

        subject.left

        expect(subject.direction).to eq('SOUTH')
      end
    end
  end
end
