source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "rails","~> 7.0.4", ">= 7.0.4.3"
gem "sprockets-rails"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "devise"
gem "bulma-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw], group: :test
  gem "pry-byebug", group: :test
  gem "pry-rails", group: :test
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "spring-commands-rspec"
end

