require 'yaml'
require 'ruby_hid'

require_relative('./field.rb')
require_relative('./worm.rb')
require_relative('./target.rb')

Dir.glob(File.dirname(__FILE__) + '/worms/*.rb').each{|x| require x }

require_relative('./game.rb')


