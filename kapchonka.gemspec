$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "kapchonka/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "kapchonka"
  s.version     = Kapchonka::VERSION
  s.authors     = ["Edgar Meinart"]
  s.email       = ["edgars@meinarts.name"]
  s.homepage    = "https://github.com/AlianceBloom/kapchonka"
  s.summary     = "Simple captcha"
  s.description = "Simple captcha"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rails', '~> 4.1.8'
  s.add_runtime_dependency  'slim'
  s.add_runtime_dependency  'rmagick'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'redis'
end
