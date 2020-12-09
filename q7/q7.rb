lines = IO.readlines("input.txt", chomp: true)
lines = lines.reject { |line| line.include? "no other bags" }

graph = lines.to_h do |rule|
  bag, contents = rule.split(" bags contain ")
  contents = contents.split(", ").map { |c|
    num, color = c.split("\s", 2)
    {num: num.to_i, color: color.sub(/\sbag[s]*\.*$/, '')}
  }
  [bag, contents]
end

inverted = Hash.new {|h, k| h[k] = []}
graph.each_pair do |bag, contents|
  contents.each { |c| inverted[c[:color]] << bag }
end

# part 1
def parents(g, bag)
  g[bag] + g[bag].map {|b| parents(g, b)}.flatten
end
parents(inverted, 'shiny gold').uniq.size

# part 2
def count_bags(g, bag)
  return 0 if !g[bag]
  g[bag].sum { |b| b[:num] + (b[:num] * count_bags(g, b[:color]))}
end
count_bags(graph, 'shiny gold')
