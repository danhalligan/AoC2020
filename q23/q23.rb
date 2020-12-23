load './circularlist.rb'

class CrabCups
  attr_accessor :x

  def initialize(input)
    @x = CircularList.new
    input.split('').each { |v| @x.insert(v.to_i) }
    @max = @x.max
  end

  def move
    v = @x.head.data
    hold = @x.remove_n 3
    target = v
    loop do
      target -= 1
      target = @max if target < 1
      break unless hold.include? target
    end
    @x.insert_next @x.find_first {|e| e.data == target}, hold
    @x.head = @x.head.next
  end

  def play(n = 10)
    n.times do
      move
    end
    @x.head = @x.find_first {|e| e.data == 1}
    @x.to_a.drop(1).join('')
  end

  def playb(n = 10000000)
    l = @x.to_a.last
    add = (@x.max + 1)..(1e6)
    @x.insert_next @x.find_first {|e| e.data == l}, add
    @max = 1e6
    i = 0
    n.times do
      i += 1
      print '.'
      move
    end
    @x
  end

end


CrabCups.new('389125467').play(100) # 67384529
CrabCups.new('685974213').play(100) # 82635947

r = CrabCups.new('685974213').playb(10000000)

r = playb('685974213', 10000000)
x.head = x.find_first {|e| e.data == 1}
x.to_a.drop(1).join('')

