#!/usr/bin/ruby

require '../lib/load_lib.rb'

infile = ARGV[0] || 'input.txt'
memory = File.readlines(infile)[0].strip.split(',').map(&:to_i)

100.times do |noun|
  100.times do |verb|
    memory[1] = noun
    memory[2] = verb

    vm = Intcode::Interpreter.new(memory)
    vm.run
    if vm.memory_read(0) == 19690720
      puts "Solution: #{100 * noun + verb}"
      exit
    end
  end
end
puts 'No solution found :('
