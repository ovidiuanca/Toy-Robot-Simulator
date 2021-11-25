# frozen_string_literal: true

require './lib/operation_reader'
require './lib/operation_validator'
require './lib/operation'
require './lib/toy'
require './lib/map'

class Playground
  attr_reader :map, :reader, :operations, :toy

  def initialize(filename)
    @map = Map.new
    @reader = OperationReader.new(filename)

    @reader.read
    @operations = reader.operations

    raise FirstOperationNotPlaceError unless operations.first.type == 'PLACE'
  end

  def run
    toy = Toy.new(map: map)

    operations.each do |operation|
      case operation.type
      when 'PLACE'
        toy.place(operation)
      when 'MOVE'
        toy.move
      when 'RIGHT'
        toy.right
      when 'LEFT'
        toy.left
      when 'REPORT'
        toy.report
      else
        raise NotImplementedOperationError
      end
    end
  end
end
