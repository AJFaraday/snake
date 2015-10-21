class TrainWorm < Worm

  def class_initialize(config={})
    until @x_speed != 0 or @y_speed != 0
      @x_speed = config['x_speed'] || (rand(3) - 1)
      @y_speed = config['y_speed'] || (rand(3) - 1)
    end
  end

  def update_position
    start_x = @x_position
    @x_position += @x_speed
    x_changed = start_x.to_i != @x_position.to_i

    start_y = @y_position
    @y_position += @y_speed
    y_changed = start_y.to_i != @y_position.to_i

    @position_changed = true if x_changed or y_changed
  end

end