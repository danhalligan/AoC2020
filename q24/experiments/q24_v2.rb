load './tiles.rb'
dat = IO.readlines("test.txt", chomp: true).map { |l| l.scan /[sn]*[ew]/ }

def nblack(floor)
  floor.keys.count { |pos| floor[pos].color == "black" }
end

floor = Hash.new { |h,k| h[k] = Tile.new(pos: k) }
dat.each do |l|
  tile = Tile.new(color: 'black')
  l.each { |x| tile.move(x) }
  if floor.key? tile.pos
    floor[tile.pos].flip!
  else
    floor[tile.pos] = tile
  end
end

nblack(floor)

i = 0
10.times do
  i += 1
  coords = []
  floor.keys.each { |k| coords += floor[k].neighbours + [floor[k].pos] }
  coords = coords.sort.uniq
  toflip = Hash.new { |h,k| h[k] = false }
  coords.each do |k|
    nsum = floor[k].neighbours.count { |x| floor[x].black? }
    if floor[k].black? && (nsum == 0 || nsum > 2)
      toflip[k] = true
    elsif !floor[k].black? && nsum == 2
      toflip[k] = true
    end
  end
  toflip.keys.each {|k| floor[k].flip! }
  puts "#{i} #{nblack(floor)}"
end
