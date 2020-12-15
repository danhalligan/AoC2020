dat = IO.readlines('input.txt', chomp: true)

# part a
mem = {}
dat.each do |line|
  if line.match(/mask = (\w+)/)
    mask = $1
    on = mask.gsub('X', '0').to_i(2)
    off = mask.gsub('X', '1').to_i(2)
  else
    address, value = line.match(/mem\[(\d+)\] = (\d+)/).captures.map(&:to_i)
    mem[address] = (value | on) & off
  end
end
mem.values.sum

# part b
mem = {}
dat.each do |line|
  if line.match(/mask = (\w+)/)
    mask = $1
    on = mask.gsub('X', '0').to_i(2)
    floats = mask.split(//).each_index.select {|i| mask[i] == "X" }
  else
    address, value = line.match(/mem\[(\d+)\] = (\d+)/).captures.map(&:to_i)
    address = address | on
    [0,1].repeated_permutation(floats.length).each {|p|
      add = address.to_s(2).rjust(36, '0')
      floats.each_with_index { |f, i| add[f] = p[i].to_s }
      # puts "Writing #{value} to #{add.to_i(2)}"
      mem[add.to_i(2)] = value
    }
  end
end
mem.values.sum
