$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'open4'

if ENV['CAPYBARA']
  require 'capybara/cucumber'
  require 'mechanical-cuke/capybara'
  Capybara.default_driver = :mechanical_cuke
  Capybara.save_and_open_page_path = File.dirname(__FILE__) + '/../../tmp'
else
  require 'mechanical-cuke'
end

require 'test/unit/assertions'

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
