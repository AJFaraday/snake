class ScoreBoard

  attr_accessor :data_file, :data

  def ScoreBoard.add_time(level, player, time)
    board = ScoreBoard.new(level)
    board.add(player, time)
  end

  def initialize(level)
    file_path = File.join(
      File.dirname(__FILE__),
      '..',
      'working_data',
      'score_boards',
      "#{level}.yml"
    )
    if File.exists?(file_path)
      @data = YAML.load_file(file_path)
      @data_file = File.open(file_path, 'w')
    else
      @data ||= []
      @data_file = File.open(file_path, 'w+')
    end
  end

  def add(player, time)
    @data << {
      player: player,
      time: time
    }
    @data.sort! { |a, b| a[:time] <=> b[:time] }
    save_data
  end

  def save_data
    File.write(@data_file.path, @data.to_yaml)
  end

end