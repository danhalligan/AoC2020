# Read data, split to groups and then split lines to character arrays
dat = IO.read("input.txt").split("\n\n").map do |g|
  g.split("\n").map(&:chars)
end

# Part 1
dat.map { |g| g.reduce(:|).length }.sum

# Part 2
dat.map { |g| g.reduce(:&).length }.sum
