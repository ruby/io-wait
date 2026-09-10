require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs = ["lib", "test/lib"]
  t.ruby_opts << "-rhelper"
  t.options = "--ignore-name=/ungetc_in_text/"
  t.test_files = FileList["test/**/test_*.rb"]
end

task :default => :test
