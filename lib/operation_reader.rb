# frozen_string_literal: true

class OperationReader
  attr_reader :operations

  def initialize(path)
    @file = File.open(path)

    @operations = []
  end

  def read
    File.readlines(file).map(&:strip).each do |operation|
      operation = Operation.new(operation)
      operation.build!
      operations << operation
    end
  end

  private

  attr_reader :file
end
