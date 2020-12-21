# Read data
foods = IO.readlines("input.txt", chomp: true).map do |line|
  line = line.sub(/\s*\(contains\s(.+)\)/, '')
  contains = $1.split(', ')
  ingredients = line.split(' ')
  {i: ingredients, a: contains}
end

# build map of allergens to possible ingredients
allergens = foods.map { |x| x[:a] }.flatten.uniq.sort
ahash = allergens.map do |a|
  ing = foods.select {|f| f[:a].include? a }.map { |f| f[:i] }.reduce(&:&)
  [a, ing]
end.to_h

# find cases where there's only one possibility, drop that option from others
# and continue till we have assigned everything.
found = {}
while ahash.length > 0
   singles = ahash.select {|k,v| v.length == 1 }
   found = found.merge(singles)
   sk = singles.keys
   sv = singles.values.flatten
   ahash = ahash.map {|k,v| [k, v - sv] }.to_h
   ahash = ahash.select {|k, v| !sk.include? k }
end

# part a
ingredients = foods.map { |x| x[:i] }.flatten.uniq.sort
invalid = ingredients - found.map{|k,v| v}.flatten
ingred = foods.map { |x| x[:i] }.flatten
are_invalid = ingred.map { |i| invalid.include?(i) }
puts are_invalid.count(true)

# part b
puts found.keys.sort.map {|x| found[x]}.join(',')

