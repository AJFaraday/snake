class Player < Worm

  attr_accessor :controller

  def class_initialize
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
    @x_position += @x_speed
    @y_position += @y_speed
  end

  def set_random_position
    @x_position = rand(field.width)
    @y_position = rand(field.height)
    @changed = true
  end

end