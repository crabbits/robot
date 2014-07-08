#!/usr/bin/env ruby 

require 'robot'
require 'optparse'

def place_params_valid?(args)
  !args[1].nil? and args[1].split(',').length == 3
end

def place_robot(args)
  x_axis, y_axis, orientation = args[1].split(',').each { |arg| arg }
  @robot.place(x_axis.to_i, y_axis.to_i, orientation)
end

def robot_moves_for(args)

  case args[0].downcase
  when "place"
    place_robot(args) if place_params_valid?(args)

  when "right"
    @robot.right

  when "left"
    @robot.left

  when "move"
    @robot.move

  when "report"
    puts @robot.report_position if @robot.position

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

@robot = Robot::Robot.new

ARGV[0].nil? ? puts(@option_parser) : robot_moves_for(ARGV)

while( user_input = $stdin.gets.chomp)

  args = user_input.split(' ').collect { |opt| opt }
  break if robot_moves_for(args) == false

end
