class OperationValidator
  VALID_OPERATIONS = %w[
    MOVE
    LEFT
    RIGHT
    REPORT
  ].freeze

  VALID_DIRECTIONS = %w[
    NORTH
    EAST
    SOUTH
    WEST
  ].freeze

  def initialize(operation)
    @operation = operation
  end

  def validate!
    if VALID_OPERATIONS.include?(operation) || place_command?
      operation
    else
      raise NotValidOperationError
    end
  end

  private

  attr_reader :operation

  def place_command?
    return false unless operation

    first_argument, second_argument = operation.split

    return false unless two_arguments?
    return false unless first_argument_valid?(first_argument)
    return false unless second_argument_valid?(second_argument)

    true
  end

  def two_arguments?
    operation.split.size == 2
  end

  def first_argument_valid?(first_argument)
    first_argument == 'PLACE'
  end

  def second_argument_valid?(second_argument)
    return false unless second_argument.split(',').size == 3

    x, y, direction = second_argument.split(',')

    [x, y].each { |e| Integer(e) } # raises ArgumentError if e is not numeric

    return false unless VALID_DIRECTIONS.include?(direction)

    true
  rescue ArgumentError
    false
  end
end
