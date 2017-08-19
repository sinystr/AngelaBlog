require 'sinatra/activerecord/rake'
require 'rspec/core/rake_task'

namespace :db do
  task :load_config do
    require './app'
  end
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
  t.rcov = true
end

task :default => [:spec]
