class Game

  attr_accessor :field, :config, :players

  def initialize
    @config = YAML.load_file(File.dirname(__FILE__) + '/../config.yml')
    @frame_time = @config['frame_time'].to_f
    raise "Frame time must be more than zero" if @frame_time == 0
    @field = Field.new(self)
    initialize_worms
    self.draw
  end

  def initialize_worms
    @worms = []
    @config['worms'].each do |kls|
      @worms << Kernel.const_get(kls).new(self)
    end
  end

  def run
    loop do
      tick
      sleep @frame_time
    end
  end

  def tick
    field.reduce_cells
    @worms.each do |worm|
      worm.update
    end
    draw
  end

  def draw
    @field.draw
  end

end