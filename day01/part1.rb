#!/usr/bin/env ruby

total = 0
File.readlines('input.txt').map(&:strip).each do |l|
  mass = l.to_i
  fuel = (mass / 3).to_i - 2
  total += fuel
end
puts total
