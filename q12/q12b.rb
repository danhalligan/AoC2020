class Boat
  attr_reader :pos, :dir, :waypoint

  def initialize(dir = 90)
    @dir = dir
    @pos = [0, 0]
    @waypoint = [10, 1]
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
    @pos = [v * @waypoint[0] + @pos[0], v * @waypoint[1] + @pos[1]]
  end

  def north(v)
    @waypoint = [@waypoint[0], @waypoint[1] + v]
  end

  def south(v)
    @waypoint = [@waypoint[0], @waypoint[1] - v]
  end

  def east(v)
    @waypoint = [@waypoint[0] + v, @waypoint[1]]
  end

  def west(v)
    @waypoint = [@waypoint[0] - v, @waypoint[1]]
  end

  def left(v)
    wrotate(v)
  end

  def right(v)
    wrotate(-v)
  end

  def wrotate(v)
    r = v * Math::PI / 180
    @waypoint = [
      @waypoint[0] * Math::cos(r) - @waypoint[1] * Math::sin(r),
      @waypoint[1] * Math::cos(r) + @waypoint[0] * Math::sin(r)
    ]
  end
end

x = IO.readlines("input.txt", chomp: true)
b = Boat.new()
x.each {|str|
   b.move!(str)
   pp str, b.pos, b.dir, b.waypoint
   puts
}
b.dist

