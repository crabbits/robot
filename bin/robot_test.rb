#!/usr/bin/env ruby

require 'open3'
require 'expect'

class Test

  attr_accessor :tests, :passes, :test_cases

  def initialize
    @tests = 0
    @passes = 0
    @test_cases = []
  end

  def run_all_test_cases
    test_cases.each { |test_case| run_test_case(test_case, self) }
    print_overall
  end

  def run_test_case(test_case, test)
    test_case.summary
    test_case.run_for(test)
    puts ""
  end

  def print_overall
    puts "#{passes} out of #{tests} test passing"
  end
end

class TestCase

  attr_accessor :title, :commands, :expected_output

  def initialize(title, commands, expected_output)
    @title = title
    @commands = commands
    @expected_output = expected_output
  end

  def summary
    print_title
    puts ""
    print_commands
    puts ""
  end

  def run_for(test)
    output = output_for_commands
    add_results_to_test(test, output)
    print_results_for(test, output)
  end

  def add_results_to_test(test, output)
    test.tests += 1
    test.passes += 1 if passed_for?(expected_output, output) 
  end

  def print_results_for(test, output)
    puts "  Results"
    puts "  #{"=" * 28}"
    puts "  Expected: #{ expected_output }"
    puts "  Actual:   #{output}"
    puts "  #{result_for(expected_output, output)}"
  end

  private

  def output_for_commands
    output = nil
    Open3.popen3("ruby bin/robot.rb") do |i, o, e, t|
      i.sync = true
      o.sync = true
      commands.each { |command| i.puts command }
      i.puts "report"
      i.close
      output = o.read
    end  
    output
  end

  def result_for(expected_output, output)
    passed_for?(expected_output, output) ? passed_message : failed_message
  end

  def passed_for?(expected_output, output)
    expected_output == output.chop 
  end

  def passed_message
    "\033[32m#{'PASS'}\033[0m"
  end

  def failed_message
    "\033[31m#{'FAIL'}\033[0m"
  end

  def print_title
    puts title
    puts "=" * 30
  end

  def print_commands
    puts "  Commands"
    puts "  #{"=" * 28}"
    commands.each { |command| puts "  #{command}" }
  end
end

test_case_1_commands = []
test_case_1_commands << "PLACE 0,0,NORTH"
test_case_1_commands << "MOVE"

test_case_2_commands = []
test_case_2_commands << "PLACE 0,0,NORTH"
test_case_2_commands << "LEFT"

test_case_3_commands = []
test_case_3_commands << "PLACE 1,2,EAST"
test_case_3_commands << "MOVE"
test_case_3_commands << "MOVE"
test_case_3_commands << "LEFT"
test_case_3_commands << "MOVE"

test_case_4_commands = []
test_case_4_commands << "PLACE 0,0,WEST"
test_case_4_commands << "MOVE"
test_case_4_commands << "MOVE"
test_case_4_commands << "LEFT"
test_case_4_commands << "MOVE"
test_case_4_commands << "MOVE"

@test = Test.new

@test.test_cases << TestCase.new("Test Case 1", test_case_1_commands, "0, 1, NORTH")
@test.test_cases << TestCase.new("Test Case 2", test_case_2_commands, "0, 0, WEST")
@test.test_cases << TestCase.new("Test Case 3", test_case_3_commands, "3, 3, NORTH")
@test.test_cases << TestCase.new("Test Case 4", test_case_4_commands, "0, 0, SOUTH")

@test.run_all_test_cases
