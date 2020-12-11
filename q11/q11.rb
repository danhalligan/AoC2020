def pad(dat)
  h = dat.length
  w = dat[0].length
  [['p']*(w+2)] + dat.map{|x| ['p'] + x + ['p']} + [['p']*(w+2)]
end

def update(dat, min, &block)
  ndat = dat.map(&:clone)
  for r in 1..(dat.length - 2)
    for c in 1..(dat[0].length - 2)
      neighbours = yield(dat, r, c)
      ndat[r][c] = 'L' if dat[r][c] == '#' && neighbours >= min
      ndat[r][c] = '#' if dat[r][c] == 'L' && neighbours == 0
    end
  end
  ndat
end

def iterate(dat, min, &block)
  dat = pad(dat)
  loop do
    ndat = update(dat, min, &block)
    break if ndat == dat
    dat = ndat
  end
  dat.map{|x| x.map {|v| v == '#' }.count(true)}.sum
end

dat = IO.readlines('input.txt', chomp: true).map do |x|
  x.split('')
end

# part 1
iterate(dat, 4) do |dat, i, j|
  coords = [[i-1, j-1], [i, j-1], [i+1, j-1], [i-1, j], [i+1, j], [i-1, j+1], [i, j+1], [i+1, j+1]]
  coords.map {|c| dat[c[0]][c[1]] == '#' }.count(true)
end

# part 2
iterate(dat, 5) do |dat, i, j|
  directions = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
  count = 0
  h = dat.length - 1
  w = dat[0].length - 1
  directions.each do |d|
    dist = 0
    loop do
      dist += 1
      y, x = d[0]*dist + i, d[1]*dist + j
      break if not (y > 0 and y < h and x > 0 and x < w) or dat[y][x] == 'L'
      if dat[y][x] == '#'
        count += 1
        break
      end
    end
  end
  count
end
