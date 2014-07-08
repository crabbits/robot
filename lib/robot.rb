require "robot/position"
require "robot/version"

module Robot
  class Robot
    attr_accessor :position

    def initialize(args={})
      place(*args[:position]) if args[:position]
    end

    def place(x, y, orientation)
      position = Position.wrapper(x, y, orientation)
      @position = position unless position.nil?
    end

    def report_position
      "#{position.x_axis}, #{position.y_axis}, #{position.orientation.upcase}"
    end

    def move
      position.move if has_position?
    end

    def left
      position.turn_left if has_position?
    end

    def right
      position.turn_right if has_position?
    end

    private

    def has_position?
      !@position.nil?
    end
  end
end
