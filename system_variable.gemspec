$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "system_variable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = "system_variable"
  spec.version       = SystemVariable::VERSION
  spec.authors       = ["Santiago Herrera"]
  spec.email         = ["santiago@snapsheet.me"]

  spec.summary       = %q{Database-driven environment variables}
  spec.homepage      = "https://github.com/bodyshopbidsdotcom/system_variable"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['github_repo'] = 'https://github.com/bodyshopbidsdotcom/system_variables'
    spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/bodyshopbidsdotcom'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
    'public gem pushes.'
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_development_dependency 'annotate', '~> 2.7'
  spec.add_development_dependency 'brakeman', '~> 4.7'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'factory_bot_rails', '~> 5.1'
  spec.add_development_dependency 'faker', '~> 2.10'
  spec.add_development_dependency 'generator_spec', '~> 0.9'
  spec.add_development_dependency 'mysql2', '~> 0.5'
  spec.add_development_dependency 'pry-byebug', '~> 3.7'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'rails', '~> 5.2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.9'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'shoulda-matchers', '~> 4.1'
end
