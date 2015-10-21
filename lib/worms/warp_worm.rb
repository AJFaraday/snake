class WarpWorm < Worm

  def class_initialize(config={})
    until @x_speed != 0 or @y_speed != 0
      @x_speed = config['x_speed'] || (rand(3) - 1)
      @y_speed = config['y_speed'] || (rand(3) - 1)
    end
    @steps = 1
    @jump = config['jump'] || 5
  end

  def update_position
    if @steps % @jump == 0
      if @y_speed == 0
        set_position(@x_position, rand(@field.height))
      elsif @x_speed == 0
        set_position(rand(@field.width), @y_position)
      else
        set_position(rand(@field.width), rand(@field.height))
      end
    end

    start_x = @x_position
    @x_position += @x_speed
    x_changed = start_x.to_i != @x_position.to_i

    start_y = @y_position
    @y_position += @y_speed
    y_changed = start_y.to_i != @y_position.to_i

    if x_changed or y_changed
      @position_changed = true
      @steps += 1
    end
  end

end