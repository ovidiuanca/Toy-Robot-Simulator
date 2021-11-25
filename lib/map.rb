# frozen_string_literal: true

class Map
  attr_accessor :width, :height

  def initialize(width: 5, height: 5)
    @width = width
    @height = height
  end
end
