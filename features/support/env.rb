$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'mechanical-cuke'

require 'test/unit/assertions'

World(Test::Unit::Assertions)
