class Target

  attr_accessor :x_position, :y_position

  def initialize(game)
    @game = game
    @field = game.field
    new_position
  end

  def new_position
    @x_position = rand(@field.width)
    @y_position = rand(@field.height)
    @field.set_cell(@x_position, @y_position, -1)
  end

  def update
    new_position unless @field.target_at?(@x_position, @y_position)
  end

end