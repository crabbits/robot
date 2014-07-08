#!/usr/bin/env ruby 

require 'robot'
require 'optparse'

def place_params_valid?(args)
  !args[1].nil? and args[1].split(',').length == 3
end

def build_robot(args)
  x_axis, y_axis, orientation = args[1].split(',').each { |arg| arg }

  position = Robot::Position.wrapper(x_axis.to_i, y_axis.to_i, orientation)
  position ? Robot::Robot.new(position) : nil
end

def robot_moves_for(args)

  case args[0].downcase
  when "place"
    @robot = build_robot(args) || @robot if place_params_valid?(args)
    true

  when "right"
    @robot.right if @robot
    true

  when "left"
    @robot.left if @robot
    true

  when "move"
    @robot.move if @robot
    true

  when "report"
    puts @robot.report_position if @robot
    true

  when "exit"
    false

  else
    puts @option_parser
  end
end

options = {}

@option_parser = OptionParser.new do |opts|
  opts.banner = "Usage: robot.rb COMMAND"
  opts.separator ""
  opts.separator "Commands"
  opts.separator "    PLACE X,Y,O: Places the robot if placement is valid"
  opts.separator "    RIGHT: Turns the robot 90 degrees to the right"
  opts.separator "    LEFT: Turns the robot 90 degrees to the left"
  opts.separator "    MOVE: Moves the robot 1 space in the direction it is facing"
  opts.separator "    REPORT: Reports the robot's x position, y position and orientation" 
  opts.separator "    EXIT: Shutdown robot"
  opts.separator ""

  opts.on("-h", "--help", "help") { puts @option_parser } 
end

@option_parser.parse!

ARGV[0].nil? ? puts(@option_parser) : robot_moves_for(ARGV)

while( user_input = $stdin.gets.chomp)

  args = user_input.split(' ').collect { |opt| opt }
  break unless robot_moves_for(args)	

end
