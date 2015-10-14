class Player < Worm

  attr_accessor :controller

  def class_initialize
    @controller = RubyHid::Device.new(RubyHid::Device.list[0])
  end

end