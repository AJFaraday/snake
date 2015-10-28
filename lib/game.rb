class Game

  include GameComponents::Initialisers
  include GameComponents::Endings

  attr_accessor :field, :config, :targets, :level, :worms, :player

  def initialize(first_level = nil)
    @config = YAML.load_file(File.dirname(__FILE__) + '/../config.yml')
    @lives = @config['lives']
    @frame_time = @config['frame_time'].to_f
    get_player
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
    draw_header
    @field.draw
    @worms.each do |worm|
      worm.draw
    end
  end

  def draw_header
    header_parts = [
      level_name.ljust(@field.width/3),
      level_time.center(@field.width/3),
      lives_text.rjust(@field.width/3)
    ]
    puts header_parts.join('')
  end

  def level_name
    @level.filename
  end

  def level_time
    @level.seconds_since_start.to_s
  end

  def lives_text
    "Lives: #{@lives}"
  end

end