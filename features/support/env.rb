$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')

require 'mechanical-cuke'

require 'test/unit/assertions'

require 'open4'

World(Test::Unit::Assertions)

Before do
  @server ||= {}
  server_app = File.dirname(__FILE__) + '/../../test/fixtures/server/server.rb'
  @server[:pid], @server[:stdin], @server[:stdout], @server[:stderr] =
    Open4::popen4 server_app
  status = @server[:stdout].readline
  raise "Server startup failed" if status !~ /Sinatra.* has taken the stage on/ 
end

After do
  if @server[:pid]
    Process.kill('HUP', @server[:pid])
  end
end
