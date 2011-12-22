require 'lib/tokenifier/version'

Gem::Specification.new do |s|
  s.name          = 'tokenifier'
  s.version       = Tokenifier::VERSION
  s.authors       = ['Dmtiry Larkin']
  s.email         = ['dmitry.larkin@gmail.com']
  s.homepage      = 'https://github.com/ludo/tokenifier'
  s.summary       = 'Tokenifier Gem'
  s.description   = 'Tokenifier is a Gibberish gem wrapper. It provides an aproach to encrypt and decrypt structures like Strings, Hashes.'

  s.add_runtime_dependency 'gibberish', '~>1.2'
  s.add_development_dependency 'rspec', '>= 2.6.0'

  s.require_path  = 'lib'
  s.files         = Dir['{lib,spec,rails_generators}/**/*', 'bin/tokenifier', "[a-zA-Z]*"]
  s.test_files    = Dir['spec/**/*']
  s.executables   = ['tokenifier']
end
