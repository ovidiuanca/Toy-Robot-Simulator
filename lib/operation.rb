# frozen_string_literal: true

class Operation
  attr_reader :type, :x, :y, :direction

  def initialize(input)
    @input = input
  end

  def build!
    validate!

    if place_operation?
      first_argument, second_argument = input.split

      @type = first_argument
      x, y, direction = second_argument.split(',')

      @x = x.to_i
      @y = y.to_i
      @direction = direction

    else
      @type = input
    end
  end

  def validate!
    OperationValidator.new(input).validate!
  end

  private

  attr_reader :input

  def place_operation?
    input.split.size == 2
  end
end
