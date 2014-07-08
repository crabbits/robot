require 'spec_helper'

describe Robot do

  subject { Robot::Robot.new(position: [0, 0, "NORTH"]) }

  its(:position) { should_not be_nil }

  describe "report_position" do

    let (:robot) { Robot::Robot.new(position: [0, 0, "NORTH"]) }

    it "should report the correct position after moving the robot with valid movements" do
      valid_moves_for(robot)
      expect(robot.report_position).to eq("4, 3, NORTH")
    end

    it "should report the corect position after moving the robot with invalid movements" do
      invalid_moves_for(robot)
      expect(robot.report_position).to eq("1, 2, EAST")
    end
  end

  private

  def valid_moves_for(robot)
    robot.right
    robot.move
    robot.move
    robot.move
    robot.left
    robot.move
    robot.move
    robot.right
    robot.move
    robot.left
    robot.move
  end

  def invalid_moves_for(robot)
    robot.left
    robot.move
    robot.right
    robot.right
    robot.move
    robot.left
    robot.move
    robot.move
    robot.right
  end
end
