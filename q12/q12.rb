class Boat
  attr_reader :pos, :dir

  def initialize(dir = 90)
    @dir = dir
    @pos = [0, 0]
  end

  def dist
    pos.map(&:abs).reduce(&:+).round
  end

  def move!(str)
    h = {F: :forward, N: :north, S: :south, E: :east, W: :west, L: :left, R: :right}
    self.send(h[str[0].to_sym], str[1..].to_i)
  end

  private

  def forward(v)
    raddeg = (450 - @dir) % 360
    rad = raddeg * Math::PI / 180
    north(Math.sin(rad) * v)
    east(Math.cos(rad) * v)
  end

  def north(v)
    @pos = [@pos[0], @pos[1] + v]
  end

  def south(v)
    @pos = [@pos[0], @pos[1] - v]
  end

  def east(v)
    @pos = [@pos[0] + v, @pos[1]]
  end

  def west(v)
    @pos = [@pos[0] - v, @pos[1]]
  end

  def left(v)
    @dir = (@dir - v) % 360
  end

  def right(v)
    @dir = (@dir + v) % 360
  end
end

x = IO.readlines("input.txt", chomp: true)
b = Boat.new()
x.each {|str| b.move!(str) }
b.dist

