source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
end

group :development, :test do
  gem 'rspec-rails', '~> 4.0.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'money', '~> 6.13', '>= 6.13.8'
