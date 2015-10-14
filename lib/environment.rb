require 'yaml'
require 'ruby_hid'

require_relative('./field.rb')
require_relative('./worm.rb')

Dir.glob(File.dirname(__FILE__) + '/worms/*.rb').each{|x| puts x;  require x }

require_relative('./game.rb')


