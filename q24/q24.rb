dat = IO.readlines("test.txt", chomp: true).map { |l| l.scan /[sn]*[ew]/ }

floor = Hash.new {|h,k| h[k] = 0}
dat.each do |l|
  p = [0,0]
  l.each do |x|
    even = p[1] % 2 == 0
    case x
    when 'se' then p = even ? [p[0]+1, p[1]+1] : [p[0],   p[1]+1]
    when 'e'  then p = even ? [p[0]+1, p[1]  ] : [p[0]+1, p[1]  ]
    when 'ne' then p = even ? [p[0]+1, p[1]-1] : [p[0],   p[1]-1]
    when 'sw' then p = even ? [p[0],   p[1]+1] : [p[0]-1, p[1]+1]
    when 'w'  then p = even ? [p[0]-1, p[1]  ] : [p[0]-1, p[1]  ]
    when 'nw' then p = even ? [p[0],   p[1]-1] : [p[0]-1, p[1]-1]
    end
  end
  floor[p] += 1
end

def black(v)
  v % 2 != 0
end

def nblack(floor)
  floor.keys.count {|v| black(floor[v])}
end

nblack(floor)

def neighbours(p)
  even = p[1] % 2 == 0
  [
    even ? [p[0]+1, p[1]+1] : [p[0],   p[1]+1],
    even ? [p[0]+1, p[1]  ] : [p[0]+1, p[1]  ],
    even ? [p[0]+1, p[1]-1] : [p[0],   p[1]-1],
    even ? [p[0],   p[1]+1] : [p[0]-1, p[1]+1],
    even ? [p[0]-1, p[1]  ] : [p[0]-1, p[1]  ],
    even ? [p[0],   p[1]-1] : [p[0]-1, p[1]-1]
  ]
end

i = 0
10.times do
  i += 1
  tiles = []
  floor.keys.each {|k| tiles += neighbours(k) + [k] }.sort.uniq
  flip = Hash.new {|h,k| h[k] = false}
  tiles.each do |k|
    nsum = neighbours(k).count { |x| black(floor[x]) }
    if black(floor[k]) && (nsum == 0 || nsum > 2)
      flip[k] = true
    elsif !black(floor[k]) && nsum == 2
      flip[k] = true
    end
  end
  flip.keys.each {|k| floor[k] = floor[k] % 2 == 0 ? 1 : 0 }
  puts "#{i} #{nblack(floor)}"
end
