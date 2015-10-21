class Level

  def initialize(filename)
    @filepath = File.join(
      File.dirname(__FILE__),
      '..',
      'levels',
      filename
    )
    @config = YAML.load_file(@filepath)
  end

  def [](key)
    @config[key]
  end

  def []=(key, value)
    @config[key] = value
  end

  def unlock
    self['available'] = true
    self.save
  end

  def lock
    self['available'] = false
    self.save
  end

  def save
    File.open(@filepath, 'w') do |f|
      f.write @config.to_yaml
    end
  end

end