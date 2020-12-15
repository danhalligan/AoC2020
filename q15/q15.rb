def iterate(start, n)
  lastpos = Hash.new{ |h,k| h[k] = [] }
  start.each_with_index {|x, v| lastpos[x.to_s] = [v + 1] }
  last = start[-1]
  s = start.length + 1
  (s..n).each do |i|
    pos = lastpos[last.to_s].nil? ? 0 : lastpos[last.to_s]
    last = pos.length <= 1 ? 0 : pos[1] - pos[0]
    lastpos[last.to_s] << i
    lastpos[last.to_s] = lastpos[last.to_s].pop(2)
  end
  last
end

iterate([0, 3, 6], 12)
iterate([2, 15, 0, 9, 1, 20], 2020)
iterate([2, 15, 0, 9, 1, 20], 30000000)
