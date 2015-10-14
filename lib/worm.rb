class Player

  attr_accessor :field, :x_position, :y_position
  attr_accessor :length, :speed, :x_speed, :y_speed
  attr_accessor :dead

  def initialize(game)
    @game = game
    @field = game.field
    @x_position = rand(@field.width)
    @y_position = rand(@field.height)
    @x_speed = 0
    @y_speed = 0
    @length = 5 #TODO
    @dead = false
    class_initalize if respond_to?(:class_initialize)
  end

  def update
    # drop a marker in your cell
    field.set_cell(x_position, y_position, length) unless self.dead?

    update_position

    # loop back if need be
    @x_position %= field.width
    @y_position %= field.height
  end

  def update_position
    @x_position += rand(3) - 1
    @y_position += rand(3) - 1
  end

  def dead?
    return @dead if @dead
    if field.obstacle_at?(x_position, y_position)
      @dead = true
    end
  end

end