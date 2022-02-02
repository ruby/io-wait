require "bundler/gem_tasks"
require "rake/testtask"

name = "io/wait"

case
when RUBY_VERSION < "2.6"
  task :compile do
    # noop
  end

  task :clean do
    # noop
  end
  libs = []
else
  require 'rake/extensiontask'
  extask = Rake::ExtensionTask.new(name) do |x|
    x.lib_dir.sub!(%r[(?=/|\z)], "/#{RUBY_VERSION}/#{x.platform}")
  end
  libs = ["lib/#{RUBY_VERSION}/#{extask.platform}"]
end

Rake::TestTask.new(:test) do |t|
  t.libs = libs
  t.libs << "test/lib"
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end

task :test => :compile

task :default => :test
