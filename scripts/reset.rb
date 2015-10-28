require 'fileutils'

n = 5
puts "This will destroy all working data for Ruby Worm"
puts "press ctrl + c to exit:"
until n < 0
  puts n
  sleep 1
  n -= 1
end

data_files = Dir.glob(
  File.join(
    File.dirname(__FILE__),
    '..','working_data', '**', '*.yml'
  )
)
data_files.each do |file|
  FileUtils.rm(file)
end