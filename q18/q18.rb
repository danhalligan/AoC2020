def eval_block1(s)
  while s.match? /\s/
    s.sub!(/^\d+\s.\s\d+/) { |e| eval(e) }
  end
  s.to_i
end

def eval_exprs(x)
  while x.match? /\(/
    x.gsub!(/\(([^\(]+?)\)/) { |m| yield $1 }
  end
  yield x
end

def eval_block2(s)
  while s.match? /\+/
    s.gsub!(/\d+\s\+\s\d+/) { |e| eval(e) }
  end
  eval_block1(s)
end

# part a
sums = IO.readlines('input.txt', chomp: true).map do |line|
  eval_exprs(line) { |x| eval_block1(x) }
end
puts sums.reduce(&:+)

# part b
sums = IO.readlines('input.txt', chomp: true).map do |line|
  eval_exprs(line) { |x| eval_block2(x) }
end
puts sums.reduce(&:+)
