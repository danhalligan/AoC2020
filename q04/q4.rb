passes = IO.read("input.txt").split("\n\n")
passes = passes.map { |pass|
    pass = pass.gsub("\n", " ")
    pass.split(" ").map{|x| x.split(":")}.to_h
}

required = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
passes.map { |pass| (required - pass.keys).length == 0}.count(true)


def validate(pass)
  required = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
  return false unless (required - pass.keys).length == 0
  return false unless pass['byr'].to_i >= 1920 && pass['byr'].to_i <= 2002
  return false unless pass['iyr'].to_i >= 2010 && pass['iyr'].to_i <= 2020
  return false unless pass['eyr'].to_i >= 2020 && pass['eyr'].to_i <= 2030
  return false unless pass['hcl'].match?(/^\#[\w\d]{6}$/)
  return false unless ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include? pass['ecl']
  return false unless pass['pid'].match?(/^\d{9}$/)
  if pass['hgt'].match?(/cm$/)
    hgt = pass['hgt'].sub(/cm$/, '').to_i
    return false unless hgt >= 150 && hgt <= 193
  elsif pass['hgt'].match?(/in$/)
    hgt = pass['hgt'].sub(/in$/, '').to_i
    return false unless hgt >= 59 && hgt <= 76
  else
    return false
  end
  return true
end

passes.map { |pass| validate(pass) }.count(true)
