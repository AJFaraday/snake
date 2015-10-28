require_relative('./lib/environment.rb')

if ARGV[1]
  levels = Dir.glob(
    File.join(
      File.dirname(__FILE__),
      'levels',
      "#{ARGV[1]}*"
    )
  )
  level = levels[0]
  if level
    game = Game.new(levels[0].split('/')[-1])
  else
    raise "No Level found for #{ARGV[1]}"
  end
else
  game = Game.new
end

game.run
