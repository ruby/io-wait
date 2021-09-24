if RUBY_ENGINE == 'jruby'
  require 'io/wait.jar'
  JRuby::Util.load_ext("org.jruby.ext.io.wait.IOWaitLibrary")
else
  require 'io/wait.so'
end
