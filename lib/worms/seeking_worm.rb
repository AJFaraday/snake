class SeekingWorm < Worm

  def class_initialize(config={})

  end

  def update_position
    set_direction
    
    start_x = @x_position
    @x_position += @x_speed
    x_changed = start_x.to_i != @x_position.to_i

    start_y = @y_position
    @y_position += @y_speed
    y_changed = start_y.to_i != @y_position.to_i

    @position_changed = true if x_changed or y_changed
  end
  
  def set_direction
    choose_target unless @target
    @score_marker = Integer(@score)
    if @target
      if @target.x_position > self.x_position
        @x_speed = 1
      elsif @target.x_position < self.x_position
        @x_speed = -1
      else 
        @x_speed = 0
      end
      if @target.y_position > self.y_position
        @y_speed = 1
      elsif @target.y_position < self.y_position
        @y_speed = -1
      else
        @y_speed = 0
      end
      if @score != @score_marker
        choose_target
      end
    end
  end

  def choose_target
    @target = @game.targets[rand(@game.targets.count)]
  end

end