require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "mechanical-cuke"
    gem.summary = %Q{A Mechanize driver for Cucumber}
    gem.description = %Q{A Mechanize driver for Cucumber.  Provides step definitions for driving web applications using Mechanize.}
    gem.email = "spike@indra.com"
    gem.homepage = "http://github.com/spikex/mechanical-cuke"
    gem.authors = ["Spike Ilacqua"]
    gem.add_runtime_dependency 'mechanize', '>= 1.0.0'
    gem.add_runtime_dependency "cucumber", ">= 0.8.5"
    gem.add_runtime_dependency "launchy", ">= 0.3.3"
    gem.add_development_dependency "open4", ">= 0.9.6"
    gem.add_development_dependency "cucumber-rails", ">= 0.2.4"
    gem.add_development_dependency "mocha", ">= 0.9.8"
    gem.add_development_dependency "sinatra", ">= 1.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:cucumber)

  task :cucumber => :check_dependencies

  Cucumber::Rake::Task.new(:wip, 'Run features that are in progress') do |t| 
    t.cucumber_opts = "--tags @wip:3 --wip features"
  end
rescue LoadError
  task :cucumber do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :cucumber

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mechanical-cuke #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
