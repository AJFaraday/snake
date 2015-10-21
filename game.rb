require_relative('./lib/environment.rb')

if ARGV[0]
  levels = Dir.glob(
    File.join(
      File.dirname(__FILE__),
      'levels',
      "#{ARGV[0]}*"
    )
  )
  level = levels[0]
  if level
    game = Game.new(levels[0].split('/')[-1])
  else
    raise "No Level found for #{ARGV[0]}"
  end
else
  game = Game.new
end

game.run
