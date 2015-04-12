require File.expand_path('../lib/profiler/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ['Tom Benner']
  s.email         = ['tombenner@gmail.com']
  s.description = s.summary = %q{Easy, targeted Ruby profiling}
  s.homepage      = 'https://github.com/tombenner/profiler'

  s.files         = `git ls-files`.split($\)
  s.name          = 'profiler'
  s.require_paths = ['lib']
  s.version       = Profiler::VERSION
  s.license       = 'MIT'

  s.add_development_dependency 'rspec'
end
