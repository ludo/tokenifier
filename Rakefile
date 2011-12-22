require 'rubygems'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |r|
  r.pattern = "spec/**/*_spec.rb"
  r.rspec_opts = '-fs -c'
end
