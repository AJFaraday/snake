class RandomWorm < Worm

  def update_position
    start_x = @x_position
    x_target = (@x_position + (rand(3) - 1)) % field.width

    start_y = @y_position
    y_target = (@y_position + (rand(3) - 1)) % field.height

    unless field.obstacle_at?(x_target, y_target)
      set_position(x_target, y_target)
    end

    x_changed = start_x.to_i != @x_position.to_i
    y_changed = start_y.to_i != @y_position.to_i
    @position_changed = true if x_changed or y_changed
  end

end