class Player < Worm

  attr_accessor :controller

  def class_initialize(config={})
    @controller = RubyHid::Device.new(RubyHid::Device.list[0])
    init_controller_observers
  end

  def init_controller_observers
    btn = RubyHid::Button.find_by_name(:btn_3)
    btn.add_event(lambda {|value| self.set_random_position if value == 1 })

    axis = RubyHid::Button.find_by_name(:left_x)
    axis.add_event(lambda {|value| self.x_speed = (((value.to_f / 255.0) - 0.5) * speed) })

    axis = RubyHid::Button.find_by_name(:left_y)
    axis.add_event(lambda {|value| self.y_speed = (((value.to_f / 255.0) - 0.5) * speed) })

    @controller.start_watching
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