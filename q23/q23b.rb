class CrabCups
  class Node
    attr_accessor :next, :data
    def initialize data
      @data = data
      @next = nil
    end
  end

  attr_accessor :map

  def initialize(x)
    @map = {}
    prev = nil
    x.each do |v|
      @map[v] = Node.new(v)
      prev.next = @map[v] if prev
      prev = @map[v]
    end
    prev.next = @map[x[0]]
    @max = x.max
    @c = @map[x[0]]
  end

  def move
    hold = [@c.next, @c.next.next, @c.next.next.next]
    @c.next = hold[-1].next

    target = @c.data
    loop do
      target -= 1
      target = @max if target < 1
      break unless hold.map{|v| v.data}.include? target
    end

    target = @map[target]

    hold[-1].next = target.next
    target.next = hold[0]
    @c = @c.next
  end

  def result_a
    v = @map[1]
    a = []
    @map.length.times {
      a << v.data
      v = v.next
    }
    a.drop(1).join("")
  end

  def result_b
    @map[1].next.data * @map[1].next.next.data
  end

  def play(n = 10)
    n.times { move }
    self
  end
end

# test
test = '389125467'.split('').map(&:to_i)
puts CrabCups.new(test).play.result
puts CrabCups.new(test).play(100).result_a

# part a
dat = '685974213'.split('').map(&:to_i)
puts CrabCups.new(dat).play(100).result_a   # 82635947

# part b
puts  CrabCups.new(dat + (10..1e6).to_a).play(10000000).result_b

