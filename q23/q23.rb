load './crabcups.rb'

# test
test = '389125467'.split('').map(&:to_i)
CrabCups.new(test).play.result_a == '92658374'
CrabCups.new(test).play(100).result_a == '67384529'

# part a
dat = '685974213'.split('').map(&:to_i)
puts CrabCups.new(dat).play(100).result_a   # 82635947

# part b
puts  CrabCups.new(dat + (10..1e6).to_a).play(10000000).result_b
