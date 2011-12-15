# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pixy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nihad Abbasov"]
  gem.email         = ["mail@narkoz.me"]
  gem.description   = %q{Pixy is an API wrapper for Pixiv url shortener - p.tl}
  gem.summary       = %q{API wrapper for Pixiv url shortener}
  gem.homepage      = "https://github.com/narkoz/pixy"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "pixy"
  gem.require_paths = ["lib"]
  gem.version       = Pixy::VERSION

  gem.add_runtime_dependency 'json'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
end
