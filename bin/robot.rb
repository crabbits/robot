#!/usr/bin/env ruby 

require 'robot'

def build_robot(args)
  x_axis, y_axis, orientation = args[1].split(',').each { |arg| arg }

  position = Robot::Position.wrapper(x_axis.to_i, y_axis.to_i, orientation)
  position ? Robot::Robot.new(position) : nil
end

def robot_moves_for(args)

  case args[0].downcase
  when "place"
    @robot = build_robot(args) || @robot
  
  when "right"
    @robot.right if @robot
  
  when "left"
    @robot.left if @robot
  
  when "move"
    @robot.move if @robot
  
  when "report"
    puts @robot.report_position if @robot
  
  else
    puts "none"
  end
end

robot_moves_for(ARGV)

while( user_input = $stdin.gets.chomp)

  args = user_input.split(' ').collect { |opt| opt }
  robot_moves_for(args)	

end
