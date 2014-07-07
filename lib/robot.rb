require "robot/position"
require "robot/version"

module Robot
  class Robot
    attr_accessor :position

    def initialize(position)
      @position = position
    end

    def report_position
      "#{position.x_axis}, #{position.y_axis}, #{position.orientation.upcase}"
    end

    def move
      position.move
    end

    def left
      position.turn_left
    end

    def right
      position.turn_right
    end
  end
end
