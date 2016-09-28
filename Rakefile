Dir['lib/tasks/*.rake'].each { |rake| load rake }

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
