require "bundler/gem_tasks"
require "rake/testtask"

name = "io/wait"

if RUBY_VERSION < "2.6"
  task :compile do
    # noop
  end

  task :clean do
    # noop
  end
  libs = []
else
  if RUBY_PLATFORM =~ /java/
    require 'rake/javaextensiontask'
    Rake::JavaExtensionTask.new("wait") do |ext|
      require 'maven/ruby/maven'
      ext.source_version = '1.8'
      ext.target_version = '1.8'
      ext.ext_dir = 'ext/java'
      ext.lib_dir = 'lib/io'
    end
  else
    require 'rake/extensiontask'
    extask = Rake::ExtensionTask.new(name) do |x|
      x.lib_dir.sub!(%r[(?=/|\z)], "/#{RUBY_VERSION}/#{x.platform}")
    end
    libs = ["lib/#{RUBY_VERSION}/#{extask.platform}"]
  end
end

Rake::TestTask.new(:test) do |t|
  t.libs = libs
  t.libs << "test/lib"
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end

task :test => :compile

task :default => :test
