class Game

  attr_accessor :field, :config, :player

  def initialize
    @config = YAML.load_file(File.dirname(__FILE__) + '/../config.yml')
    @frame_time = @config['frame_time'].to_f
    raise "Frame time must be more than zero" if @frame_time == 0
    @field = Field.new(self)
    self.draw
  end

  def run
    loop do
      tick
      sleep @frame_time
    end
  end

  def tick
    field.update_random_cell
    field.reduce_cells
    draw
  end

  def draw
    @field.draw
  end

end