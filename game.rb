require_relative('./lib/environment.rb')

if ARGV[1]
  levels = Dir.glob(
    File.join(
      File.dirname(__FILE__),
      'levels',
      "#{ARGV[1]}*"
    )
  )
  level = levels[1]
  if level
    game = Game.new(levels[1].split('/')[-1])
  else
    raise "No Level found for #{ARGV[0]}"
  end
else
  game = Game.new
end

game.run
