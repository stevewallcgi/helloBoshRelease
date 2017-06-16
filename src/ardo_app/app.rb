require 'rubygems'
require 'sinatra'

# Unique identifier for the app's lifecycle.
# Useful for checking that an app doesn't die and come back up.
ID = SecureRandom.uuid

$stdout.sync = true
$stderr.sync = true

get '/' do
  "Hello from #{ID}!"
end

get '/env' do
  ENV.inspect
end

get '/sigterm' do
  "Available sigterms #{`man -k signal | grep list`}"
end

get '/sigterm/:signal' do
  pid = Process.pid
  signal = params[:signal]
  puts "Killing process #{pid} with signal #{signal}"
  Process.kill(signal, pid)
end

get '/log/:bytes' do
  system "cat /dev/zero | head -c #{params[:bytes].to_i}"
  "Just wrote #{params[:bytes]} bytes of zeros to the log"
end
