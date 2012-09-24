require 'rubygems'

$dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift $dir + '/../lib'

require 'minitest/unit'
require 'minitest/spec'
require 'test/unit'
require 'resque'
#
# make sure we can run redis
#

if !system("which redis-server")
  puts '', "** can't find `redis-server` in your path"
  puts "** try running `sudo rake install`"
  abort ''
end


#
# start our own redis when the tests start,
# kill it when they end
#

at_exit do
  next if $!
  processes = `ps -A -o pid,command | grep [r]edis-test`.split("\n")
  pids = processes.map { |process| process.split(" ")[0] }
  puts "Killing test redis server..."
  pids.each { |pid| Process.kill("TERM", pid.to_i) }
  system("rm -f #{$dir}/dump.rdb #{$dir}/dump-cluster.rdb")
  exit
end

puts "Starting redis for testing at localhost:9736... #{$dir}"
`redis-server #{$dir}/redis-test.conf`
Resque.redis = 'localhost:9736'
