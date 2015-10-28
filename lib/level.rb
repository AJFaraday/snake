class Level

  attr_accessor :filename

  def initialize(filename)
    @filename = filename
    @filepath = File.join(
      File.dirname(__FILE__),
      '..',
      'levels',
      @filename
    )
    @config = YAML.load_file(@filepath)
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

end