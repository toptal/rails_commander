# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'rails_commander'
  s.version     = '0.0.2'
  s.author      = 'Bartek Wilczek'
  s.email       = 'bwilczek@gmail.com'
  s.homepage    = 'http://github.com/bwilczek/rails_commander'
  s.summary     = 'Ruby wrapper for rails/rake commands'
  s.description = 'This gem provides programatical control of a Rails app'
  s.license      = 'MIT'

  s.files        = Dir['README.md', 'lib/**/*.rb']
  s.require_path = 'lib'

  s.add_dependency 'faraday'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
end
