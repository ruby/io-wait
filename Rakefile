require "bundler/gem_tasks"
require "rake/testtask"

name = "io/wait"

Rake::TestTask.new(:test) do |t|
  t.libs << "test/lib"
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end

require 'rake/extensiontask'
class << Rake::ExtensionTask.new(name)
  def evil_copy?(src, dest)
    version = %r[/\d+(?:\.\d+){1,2}/]
    src.include?(platform) and version =~ src and !(dest.include?(platform) and version =~ dest)
  end

  def install(src, dest, **)
    return if evil_copy?(src, dest)
    super
  end
  def cp(src, dest, **)
    return if evil_copy?(src, dest)
    super
  end
end

task :test => :compile

task :default => :test
