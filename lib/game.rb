class Game

  include GameComponents::Initialisers
  include GameComponents::Endings

  attr_accessor :field, :config, :players, :targets, :level, :worms

  def initialize(first_level = nil)
    @config = YAML.load_file(File.dirname(__FILE__) + '/../config.yml')
    @lives = @config['lives']
    @frame_time = @config['frame_time'].to_f
    raise "Frame time must be more than zero" if @frame_time <= 0
    first_level ||= @config['first_level']
    init_level(first_level)
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
    system('clear')
    puts "#{level_name.ljust(@field.width/2)} #{lives_text.rjust(@field.width/2)}"
    @field.draw
    @worms.each do |worm|
      worm.draw
    end
  end

  def level_name
    @level.filename
  end

  def lives_text
    "Lives: #{@lives}"
  end

end