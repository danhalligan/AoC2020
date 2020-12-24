class CrabCups
  class Node
    attr_accessor :next, :data
    def initialize data
      @data = data
      @next = nil
    end
  end

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
    hold = read(@c, 3)
    @c.next = hold[-1].next

    target = @c.data
    values = hold.map{|v| v.data}
    loop do
      target -= 1
      target = @max if target < 1
      break unless values.include? target
    end
    target = @map[target]

    hold[-1].next = target.next
    target.next = hold[0]
    @c = @c.next
  end

  def read(from, n)
    n.times.map { from = from.next }
  end

  def result_a
    read(@map[1], @map.length - 1).map(&:data).join("")
  end

  def result_b
    read(@map[1], 2).map(&:data).reduce(&:*)
  end

  def play(n = 10)
    n.times { move }
    self
  end
end
