dat = IO.readlines("test.txt", chomp: true).map { |l| l.scan /[sn]*[ew]/ }

class Tile
  attr_accessor :color, :pos

  def initialize(pos: [0, 0], color: 'white')
    @pos = pos
    @even = @pos[1] % 2 == 0
    @color = color
  end

  def inspect
    "#{color}: #{@pos}"
  end

  def black?
    @color == 'black'
  end

  def neighbours
    @neighbours ||= ['se', 'e', 'ne', 'sw', 'w', 'nw'].map { |x| dir(x) }
  end

  def flip!
    @color = black? ? 'white' : 'black'
  end

  def move(x)
    @pos = dir(x)
    @even = @pos[1] % 2 == 0
    @neighbours = nil
    self
  end

  def dir(x)
    case x
    when 'se' then @even ? [@pos[0]+1, @pos[1]+1] : [@pos[0],   @pos[1]+1]
    when 'e'  then @even ? [@pos[0]+1, @pos[1]  ] : [@pos[0]+1, @pos[1]  ]
    when 'ne' then @even ? [@pos[0]+1, @pos[1]-1] : [@pos[0],   @pos[1]-1]
    when 'sw' then @even ? [@pos[0],   @pos[1]+1] : [@pos[0]-1, @pos[1]+1]
    when 'w'  then @even ? [@pos[0]-1, @pos[1]  ] : [@pos[0]-1, @pos[1]  ]
    when 'nw' then @even ? [@pos[0],   @pos[1]-1] : [@pos[0]-1, @pos[1]-1]
    end
  end
end

