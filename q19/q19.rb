def build_regex(rules)
  re = rules['0'].clone
  while true
    nums = re.scan /\d+/
    break if nums.length.zero?
    nums.each { |num| re.gsub!(/\s*\b#{num}\b\s*/, "(#{rules[num]})") }
  end
  re
end

def count_matches(messages, re)
  messages.map {|m| m.match? /^#{re}$/ }.count(true)
end

rules, messages = IO.read("input.txt").split("\n\n").map { |x| x.split("\n") }

rules = rules.map { |rule|
  p, v = rule.split(/:\s/)
  v.gsub!(/"/, '')
  [p, v]
}.to_h

# part a
puts count_matches(messages, build_regex(rules))

# part b
rules['8'] = '42+'
rules['11'] = '(?<m>42\g<m>*31)+'
puts count_matches(messages, build_regex(rules))
