require "bundler/gem_tasks"
require "rake/testtask"

name = "io/wait"

Rake::TestTask.new(:test) do |t|
  t.libs << "test/lib"
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end

require 'rake/extensiontask'
Rake::ExtensionTask.new(name)
task :test => :compile

task :default => :test
