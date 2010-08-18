require 'mocha'
require 'launchy'

World(Mocha::API)
 
Before('@mock_launchy') do
  Launchy::Browser.expects(:run).returns(true)
  # TODO: Mock saving file...
end
 
After('@mock_launchy') do
  begin
    mocha_verify
  ensure
    mocha_teardown
  end
end
