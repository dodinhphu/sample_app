source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.0.2"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "figaro"
gem "bcrypt", "3.1.13"
gem "image_processing", "1.9.3"
gem "mini_magick", "4.9.5"
gem "active_storage_validations", "0.8.2"
gem "faker", "2.1.2"
gem "pagy"
gem "bootstrap-will_paginate", "1.0.0"
gem "rails-i18n"
gem "config"
gem "sprockets-rails"
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end
group :development do
  gem "web-console"
  gem "pry-rails"
end
group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
group :development, :test do
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end
