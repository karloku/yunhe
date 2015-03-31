
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'yunhe/version'

Gem::Specification.new do |s|
  s.name        = 'yunhe'
  s.version     = Yunhe::VERSION
  s.date        = '2015-03-31'
  s.summary     = "Hola!"
  s.description = "A simple hello world gem"
  s.authors     = ["Karloku Sang"]
  s.email       = 'karloku@loku.it'
  s.files       = `git ls-files`.split("\n")
  s.homepage    =
    'http://loku.it/yunhe'
  s.license       = 'MIT'
end