class Level

  attr_accessor :filename

  def initialize(filename, game)
    @filename = filename
    @game = game
    @filepath = File.join(
      File.dirname(__FILE__),
      '..',
      'levels',
      @filename
    )
    @config = YAML.load_file(@filepath)
    @game.player.start_level(self)
    @start_time = Time.now
  end

  def [](key)
    @config[key]
  end

  def []=(key, value)
    @config[key] = value
  end

  def save
    File.open(@filepath, 'w') do |f|
      f.write @config.to_yaml
    end
  end

  def seconds_since_start
    (Time.now - @start_time).to_i
  end

end