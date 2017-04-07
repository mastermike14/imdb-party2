# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |gem|
  gem.name          = "imdb-party"
  gem.version       = "1.1"
  gem.authors       = ["John Maddox", "Mike Mesicek"]
  gem.email         = ["jon@mustacheinc.com"]
  gem.description   = %q{Imdb JSON client used IMDB to serve information to the IMDB iPhone app via the IMDB API}
  gem.summary       = "IMDB API for Rails"
  gem.homepage      = 'https://github.com/mastermike14/imdb-party'
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  if File.exists?('UPGRADING')
    gem.post_install_message = File.read('UPGRADING')
  end

  gem.add_runtime_dependency 'rails', ['>= 4', '< 6']

  gem.add_development_dependency 'rspec-rails', '2.13.0' # 2.13.1 is broken
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'httparty'
  gem.add_development_dependency 'hpricot'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
end
