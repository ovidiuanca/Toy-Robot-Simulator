# frozen_string_literal: true

require './lib/operation_reader'
require './lib/operation_validator'
require './lib/operation'
require './lib/toy'
require './lib/map'

class Playground
  attr_accessor :map, :reader, :operations, :toy, :already_placed

  def initialize(filename)
    @map = Map.new
    @reader = OperationReader.new(filename)
    @already_placed = false

    @reader.read
    @operations = reader.operations
  end

  def run
    toy = Toy.new(map: map)

    operations.each do |operation|
      next if operation.type != 'PLACE' && !already_placed

      case operation.type
      when 'PLACE'
        @already_placed = true
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
