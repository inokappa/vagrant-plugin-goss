lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-goss/version'

Gem::Specification.new do |spec|
  spec.name          = 'vagrant-goss'
  spec.version       = VagrantPlugins::Goss::VERSION
  spec.authors       = ['inokappa']
  spec.email         = ['inokara@gmail.com']

  spec.summary       = %q{A Vagrant plugin that executes goss}
  spec.description   = 'vagrant-plugin-goss is a Vagrant plugin that integrates goss into your workflow.'
  spec.homepage      = 'https://github.com/inokappa/vagrant-plugin-goss'
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.files          = `git ls-files`.split($/)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'specinfra'

  spec.add_development_dependency 'bundler', '~> 1.17.3', '>= 1.17'
  spec.add_development_dependency 'rake', '>= 12.3.3'
end
