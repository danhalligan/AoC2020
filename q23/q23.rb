load './circularlist.rb'

def move x
  v = x.head.data
  hold = x.remove_n 3
  target = v - 1
  while (!x.include? target)
    target -= 1
    target = x.max if target < x.min
  end
  x.insert_next x.find_first {|e| e.data == target}, hold
  x.head = x.head.next
end

def parse(input)
  x = CircularList.new
  input.split('').each {|v| x.insert(v.to_i) }
  x
end

def play(input, n = 10)
  x = parse(input)
  n.times do
    move(x)
    # puts x.inspect
  end
  x.head = x.find_first {|e| e.data == 1}
  x.to_a.drop(1).join('')
end


play('389125467')
play('389125467', 100)
play('685974213', 100)


def playb(input, n = 10)
  x = parse(input)
  l = x.to_a.last
  add = (1 + x.max + 1)..(1e6 - x.length + x.max)
  x.insert_next x.find_first {|e| e.data == l}, add
  i = 0
  n.times do
    i += 1
    print '.'
    move(x)
    # puts x.inspect
  end
  x
end


r = playb('685974213', 10000000)
x.head = x.find_first {|e| e.data == 1}
x.to_a.drop(1).join('')

