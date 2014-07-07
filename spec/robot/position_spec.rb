require 'spec_helper'

describe Robot::Position do

  let(:x_axis) { 1 }
  let(:y_axis) { 2 }
  let(:orientation) { "NORTH" }
  subject { Robot::Position.new(x_axis, y_axis, orientation) }

  #its(:x_position) { should eq x_position }
  #its(:y_position) { should eq y_position }
  #its(:orientation) { should eq orientation }

  it "should return nill if the x axis isn't valid" do
    expect(Robot::Position.wrapper(-1, 0, "NORTH")).to be_nil
  end

  it "should return nill if the y axis isn't valid" do
    expect(Robot::Position.wrapper(0, 5, "NORTH")).to be_nil
  end

  it "should return nill if the orientation isn't valid" do
    expect(Robot::Position.wrapper(1, 0, "NORHF")).to be_nil
  end

  context "movements" do
 
    let(:position) { Robot::Position.new(0, 0, "NORTH") }

    describe "left" do
      
      it "changes the orientation 90 degrees to the left" do
        expect { 
	  position.turn_left
	}.to change { position.orientation }.to "west"
      end
    end

    describe "right" do

      it "changes the orientation 90 degrees to the right" do
        expect { 
	  position.turn_right
	}.to change { position.orientation }.to "east"
      end
    end

    describe "move" do
      describe "east" do
	
	before :each do
          position.turn_right
        end

	it "should move the robot by 1 east if valid" do
          expect { 
            position.move
	  }.to change { position.x_axis }.to 1
        end	

	it "shouldn't move the robot by 1 east if invalid" do
          position.x_axis = 4
          expect {
	    position.move
	  }.to_not change { position.x_axis }
	end
      end

      describe "west" do
        
	before :each do
          position.turn_left
        end

	it "should move the robot by 1 west if valid" do
          position.x_axis = 2
          expect {
	    position.move
	  }.to change { position.x_axis }.to 1
        end

	it "shouldn't move the robot by 1 west if invalid" do
           expect {
	     position.move
	   }.to_not change { position.x_axis }
        end
      end

      describe "north" do
      
        it "should move the robot by 1 north if valid" do
          expect {
	    position.move
	  }.to change { position.y_axis }.to 1
	end

	it "shouldn't move the robot by 1 north if invalid" do
          position.y_axis = 4
	  expect {
	    position.move
	  }.to_not change { position.y_axis }
	end
      end

      describe "south" do
   
	before :each do
	  position.orientation = "south"
	end

        it "should move the robot by 1 south if valid" do
          position.y_axis = 1
	  expect {
	    position.move
	  }.to change { position.y_axis }.to 0
        end

	it "shouldn't move the robot 1 south if invalid" do
          expect {
	    position.move
	  }.to_not change { position.y_axis }
        end
      end
    end
  end

  private

  def expect_error_message_for(message, x, y, o)
    expect {
      Robot::Position.new(x, y, o)
    }.to raise_error(ArgumentError, message)
  end
end
