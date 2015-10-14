class Game

  include GameComponents::Initialisers
  include GameComponents::Endings

  attr_accessor :field, :config, :players, :targets

  def initialize
    @config = YAML.load_file(File.dirname(__FILE__) + '/../config.yml')
    @frame_time = @config['frame_time'].to_f
    raise "Frame time must be more than zero" if @frame_time == 0
    @field = Field.new(self)
    initialize_worms
    initialize_targets
    self.draw
  end

  def run
    loop do
      tick
      if @ended
        system('clear')
        puts @ending_text
        break
      end
      sleep @frame_time
    end
  end

  def tick
    field.reduce_cells
    @worms.each do |worm|
      worm.update
    end
    @targets.each do |target|
      target.update
    end
    draw
  end

  def draw
    @field.draw
    @worms.each do |worm|
      worm.draw
    end
  end

end