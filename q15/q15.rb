def iterate(start, n)
  h = Hash.new { |h,k| h[k] = [] }
  start.each_with_index { |x, v| h[x] = [v + 1] }
  last = start[-1]
  ((start.length + 1)..n).each do |i|
    last = h[last].length <= 1 ? 0 : h[last][-1] - h[last][-2]
    h[last] << i
  end
  last
end

puts iterate([0, 3, 6], 12)
puts iterate([2, 15, 0, 9, 1, 20], 2020)
puts iterate([2, 15, 0, 9, 1, 20], 30000000)
