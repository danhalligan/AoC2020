# Read data
foods = IO.readlines("input.txt", chomp: true).map do |line|
  line =~ /(.+)\s\(contains\s(.+)\)/
  {i: $1.split(' '), a: $2.split(', ')}
end

# If a food has an allergen, it must contain the ingredient with that allergen
# We can get possible list of ingredients for each allergen by taking the
# intersection of ingredients across foods with that allergen.
allergens = foods.map { |x| x[:a] }.flatten.uniq.sort
assigned = allergens.to_h do |a|
  ing = foods.select {|f| f[:a].include? a }
  [a, ing.map { |f| f[:i] }.reduce(&:&)]
end

# part a
ingredients = foods.map { |x| x[:i] }.flatten
invalid = ingredients - assigned.map{|k,v| v}.flatten
are_invalid = ingredients.map { |i| invalid.include?(i) }
puts are_invalid.count(true)

# Since an allergen can only be caused by one ingredient, we can prune this list.
while assigned.values.map(&:length).max > 1
  known = assigned.select {|k,v| v.length == 1 }.values.flatten
  assigned = assigned.to_h { |k,v| [k,  v.length > 1 ? v - known : v] }
end

# part b
puts assigned.keys.sort.map {|x| assigned[x]}.join(',')

