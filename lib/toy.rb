# frozen_string_literal: true

class Toy
  attr_reader :map, :current_x, :current_y, :direction

  def initialize(map:)
    @map = map
  end

  def place(operation)
    raise PlaceOutsideOfMapError if place_outside_of_map?(operation)

    @current_x = operation.x
    @current_y = operation.y
    @direction = operation.direction
  end

  def move
    case direction
    when 'NORTH'
      return if current_y + 1 > map.height - 1

      @current_y += 1
    when 'EAST'
      return if current_x + 1 > map.width - 1

      @current_x += 1
    when 'SOUTH'
      return if (current_y - 1).negative?

      @current_y -= 1
    when 'WEST'
      return if (current_x - 1).negative?

      @current_x -= 1
    end
  end

  def right
    case direction
    when 'NORTH'
      @direction = 'EAST'
    when 'EAST'
      @direction = 'SOUTH'
    when 'SOUTH'
      @direction = 'WEST'
    when 'WEST'
      @direction = 'NORTH'
    end
  end

  def left
    case direction
    when 'NORTH'
      @direction = 'WEST'
    when 'EAST'
      @direction = 'NORTH'
    when 'SOUTH'
      @direction = 'EAST'
    when 'WEST'
      @direction = 'SOUTH'
    end
  end

  def report
    puts "#{current_x},#{current_y},#{direction}"
  end

  def place_outside_of_map?(operation)
    (operation.x > map.width - 1) || (operation.y > map.height - 1)
  end
end
