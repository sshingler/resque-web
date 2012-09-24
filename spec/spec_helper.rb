require 'rubygems'

$dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift $dir + '/../lib'

require 'rspec'
require 'resque'
require 'rack/test'

include Rack::Test::Methods

def app
  Resque::Server.new
end

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:suite) do
    puts "Starting redis for testing at localhost:9736... #{$dir}"
    puts system("redis-server #{$dir}/redis-test.conf")
    Resque.redis = 'localhost:9736'
  end

  config.after(:suite) do
    next if $!
    processes = `ps -A -o pid,command | grep [r]edis-test`.split("\n")
    pids = processes.map { |process| process.split(" ")[0] }
    puts "Killing test redis server..."
    pids.each { |pid| Process.kill("TERM", pid.to_i) }
    system("rm -f #{$dir}/dump.rdb #{$dir}/dump-cluster.rdb")
    exit
  end
end

#
# make sure we can run redis
#
if !system("which redis-server")
  puts '', "** can't find `redis-server` in your path"
  puts "** try running `sudo rake install`"
  abort ''
end
