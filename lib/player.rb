class Player

  attr_accessor :name, :data_file, :data

  def initialize(name)
    @name = name
    file_path = File.join(
      File.dirname(__FILE__),
      '..', 'players', "#{@name}.yml"
    )
    if File.exists?(file_path)
      @data = YAML.load_file(file_path)
      @data_file = File.open(file_path, 'w')
    else
      @data_file = File.open(file_path, 'w+')
      @data = {
        name: name,
        levels: {}
      }
      save_data
    end
  end

  def start_level(level)
    @current_level = level.filename.split('.')[0]
    @data[:levels][@current_level] ||= {
      available: true,
      last_start: Time.now
    }
    save_data
  end

  def end_level
    if @current_level
      level_time = Time.now - current_level[:last_start]
      current_level[:times] ||= []
      current_level[:times] << level_time
      current_level[:times] = current_level[:times].sort[0..4]
    end
  end

  def current_level
    @data[:levels][@current_level]
  end

  def save_data
    File.write(@data_file.path, @data.to_yaml)
  end

end