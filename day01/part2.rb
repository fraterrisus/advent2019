#!/usr/bin/env ruby

infile = ARGV[0] || 'input.txt'

def weight(mass)
  w0 = (mass / 3).to_i - 2
  w1 = [0, w0].max
  puts "weight(#{mass}) = #{w1}"
  w1
end

total = 0
File.readlines(infile).map(&:strip).each do |l|
  mass = l.to_i
  fuel = weight(mass)
  until fuel.zero?
    total += fuel
    fuel = weight(fuel)
  end
  STDERR.print '.'
end
STDERR.puts
STDERR.puts total
