#!/usr/bin/env ruby

def parse_direction(ch)
  case ch
  when 'U'
    [0, -1]
  when 'D'
    [0, 1]
  when 'L'
    [-1, 0]
  when 'R'
    [1, 0]
  else
    raise "Unknown direction #{ch}"
  end
end

coords = []
infile = ARGV[0] || 'input.txt'
File.readlines(infile).map(&:strip).each_with_index do |wire,idx|
  x = 0
  y = 0
  coords[idx] = {}
  steps = 0
  segments = wire.split(',').each do |segment|
    md = segment.match(/([UDLR])(\d+)/)
    dx, dy = parse_direction(md[1])
    distance = md[2].to_i

    distance.times do
      x += dx
      y += dy
      steps += 1
      coords[idx][y.to_s] ||= {}
      coords[idx][y.to_s][x.to_s] ||= steps
    end
  end
end

cross_points = []
coords[1].keys.each do |cy|
  coords[1][cy].keys.each do |cx|
    if !coords[0].dig(cy, cx).nil?
      mdist = coords[0].dig(cy, cx) + coords[1].dig(cy, cx)
      cross_points << mdist
    end
  end
end
puts "Minimum steps: #{cross_points.min}"
