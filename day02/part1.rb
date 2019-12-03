#!/usr/bin/ruby

require '../lib/load_lib.rb'

infile = ARGV[0] || 'input.txt'
memory = File.readlines(infile)[0].strip.split(',').map(&:to_i)

memory[1] = 12
memory[2] = 2

vm = Intcode::Interpreter.new(memory)
vm.run
puts vm.memory_read(0)
