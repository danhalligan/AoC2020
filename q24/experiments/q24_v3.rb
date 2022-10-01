class Neighbours
  def initialize
    @nbs = {}
  end

  def nbs(p)
    if @nbs.key?(p)
      @nbs[p]
    else
      @nbs[p] = neighbours(p)
    end
  end

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
end

def nblack(floor)
  floor.keys.count { |v| floor[v] }
end

dat = IO.readlines("test.txt", chomp: true).map { |l| l.scan /[sn]*[ew]/ }

floor = Hash.new { |h,k| h[k] = false }

nbs = Neighbours.new
dat.each do |l|
  p = [0, 0]
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
  floor[p] = !floor[p]
end

nblack(floor)

i = 0
100.times do
  i += 1
  tiles = []
  floor.keys.each {|k| tiles += nbs.nbs(k) + [k] }
  tiles = tiles.sort.uniq
  flip = Hash.new {|h,k| h[k] = false}
  tiles.each do |k|
    nsum = nbs.nbs(k).count { |x| floor[x] }
    if floor[k] && (nsum == 0 || nsum > 2)
      flip[k] = true
    elsif !floor[k] && nsum == 2
      flip[k] = true
    end
  end
  flip.keys.each {|k| floor[k] = !floor[k] }
  puts "#{i} #{nblack(floor)}"
end
