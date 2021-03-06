# To make bundle-audit happy
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.beta1.1', '< 5.1'
gem 'pg', '~> 0.18'
gem 'puma'

# switch to rubygem once it stable
gem 'jsonapi-resources', github: 'cerebris/jsonapi-resources', branch: 'master'
gem 'jsonapi-authorization'
gem 'oj'
gem 'oj_mimic_json'

# switch to rubygem once it stable
gem 'devise', github: 'plataformatec/devise', branch: 'master'
gem 'devise_token_auth', github: 'lynndylanhurley/devise_token_auth'
gem 'omniauth'

gem 'sidekiq'
gem 'sidekiq-statistic'
gem 'sinatra', github: 'sinatra/sinatra', branch: 'master', require: nil
gem 'hiredis'
gem 'redis', require: ['redis', 'redis/connection/hiredis']

gem 'seed-fu', github: 'cimtico/seed-fu', branch: 'rails_5'

gem 'hashie'

gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'twitter-text'
gem 'colorize'
gem 'friendly_id'
gem 'link_thumbnailer'
gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on'

gem 'rack-cors'

group :development do
  gem 'spring'
  gem 'annotate'
  gem 'foreman', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rerun'
  gem 'pry-rails'
  gem 'brakeman', require: false
end

group :development, :test do
  gem 'faker'
  gem 'byebug'
  gem 'rspec-core', github: 'rspec/rspec-core'
  gem 'rspec-expectations', github: 'rspec/rspec-expectations'
  gem 'rspec-mocks', github: 'rspec/rspec-mocks'
  gem 'rspec-support', github: 'rspec/rspec-support'
  gem 'rspec-rails', github: 'rspec/rspec-rails'
  gem 'fabrication'
  gem 'mocha', require: false
  gem 'shoulda', require: false
  gem 'pry-nav'
  gem 'pry-byebug'
  gem 'rubocop', '~> 0.37.2', require: false
  gem 'bundler-audit', require: false
  gem 'webmock', require: nil
end

group :test do
  gem 'coveralls', require: false
  gem 'simplecov', require: false
  gem 'database_cleaner'
  gem 'rspec_junit_formatter'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
