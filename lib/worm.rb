class Worm

  attr_accessor :field, :x_position, :y_position
  attr_accessor :length, :speed, :x_speed, :y_speed
  attr_accessor :dead, :score

  def initialize(game,config)
    @game = game
    @field = game.field
    @config = config
    @x_position = config['x'] || rand(@field.width)
    @y_position = config['y'] || rand(@field.height)
    @x_speed = 0
    @y_speed = 0
    @speed = config['speed'] || @game.level['worm_speed']
    @length = config['length'] || @game.level['starting_worm_length']
    @dead = false
    @score = 0
    @target_score = @game.level['target_score']
    class_initialize(config) if self.respond_to?(:class_initialize)
  end

  def update
    unless dead?
      @position_changed = false
      # drop a marker in your cell
      field.set_cell(x_position, y_position, length)

      update_position

      # loop back if need be
      @x_position %= field.width
      @y_position %= field.height

      update_score
    end
    game_ended?
  end

  def game_ended?
    if self.is_a?(Player)
      if self.dead?
        @game.dead_ending
      elsif @score >= @target_score
        @game.win_ending
      end
    elsif @score >= @target_score
      @game.lose_ending(self)
    end
  end

  def update_score
    if field.target_at?(@x_position, @y_position)
      @score += 1
      @length += 1
    end
  end

  def update_position
    raise "Base worm update_position called! Use a child class"
  end

  def set_position(x, y)
    @x_position = x
    @y_position = y
  end

  def set_random_position
    @x_position = rand(field.width)
    @y_position = rand(field.height)
    @position_changed = true
  end

  def dead?
    return @dead if @dead
    if @position_changed and field.obstacle_at?(x_position, y_position)
      @dead = true
    end
  end

  def draw
    puts "#{self.class.to_s.ljust(12)}: #{score}/#{@target_score} #{'DEAD!' if dead?}"
  end

end