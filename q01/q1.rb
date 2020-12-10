dat = File.read("input.txt").split.map {|x| x.to_i}
dat.combination(2).select {|x| x.sum == 2020}.first.inject(:*)
dat.combination(3).select {|x| x.sum == 2020}.first.inject(:*)
