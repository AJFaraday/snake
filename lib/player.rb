class Player

  attr_accessor :name, :data_file, :data

  def initialize(name)
    @name = name
    file_path = File.join(
      File.dirname(__FILE__),
      '..', 'players', "#{@name}.yml"
    )
    @data_file = File.open(file_path, 'w+')
    if File.exists?(file_path)
      @data = YAML.load_file(file_path)
    else
      @data = {name: name}
    end
  end

  def start_level(level)
    level_name = level.filename.split('.')[0]
    @data[:levels][level_name] ||= {available: true}
    save_data
  end

  def end_level

  end

  def save_data
    File.open(@data_file, 'w') { |f| f.write @data.to_yaml }
  end

end