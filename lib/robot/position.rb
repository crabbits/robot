module Robot
  class Position
    attr_accessor :x_axis, :y_axis, :orientation

    ORIENTATIONS = %w{north east south west}

    def initialize x, y, orientation
      @x_axis = x
      @y_axis = y
      @orientation = orientation.downcase
    end

    def move
      facing_horizontal? ? move_horizontal : move_vertical
    end

    def turn_right
      if orientation_index == ORIENTATIONS.length - 1
        @orientation = ORIENTATIONS.at(0)
      else
        @orientation = ORIENTATIONS.at(orientation_index + 1)
      end
    end

    def turn_left
      @orientation = ORIENTATIONS.at(orientation_index - 1)
    end
   
    class << self
      
      def wrapper(x, y, orientation)
        nil || Position.new(x, y, orientation) if args_valid?(x, y, orientation)
      end

      private

      def args_valid?(x, y, orientation)
        position_valid?(x) and position_valid?(y) and orientation_valid?(orientation)
      end
   
      def position_valid? position
        (0..4).include? position  
      end

      def orientation_valid? orientation
        ORIENTATIONS.include? orientation.downcase
      end
    end

    private
    
    def move_horizontal
      @orientation == "east" ? move_right : move_left
    end

    def move_vertical
      @orientation == "north" ? move_up : move_down
    end

    def move_right
      @x_axis += 1 unless @x_axis == 4
    end
  
    def move_left
      @x_axis -= 1 unless @x_axis == 0
    end 

    def move_up
      @y_axis += 1 unless @y_axis == 4
    end

    def move_down
      @y_axis -= 1 unless @y_axis == 0
    end

    def orientation_index
      ORIENTATIONS.index(orientation)
    end

    def facing_horizontal?
      ["east", "west"].include? orientation
    end
  end
end
