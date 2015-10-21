require 'yaml'
require 'ruby_hid'

require_relative('./field.rb')
require_relative('./worm.rb')
require_relative('./target.rb')
require_relative('./level.rb')

Dir.glob(File.dirname(__FILE__) + '/worms/*.rb').each{|x| require x }
Dir.glob(File.dirname(__FILE__) + '/game_components/*.rb').each{|x| require x }

require_relative('./game.rb')


