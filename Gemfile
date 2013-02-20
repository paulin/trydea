source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.1.0'
gem 'devise'
gem "kaminari"
gem "haml"
gem "haml-rails"
gem 'jquery-rails'
gem 'devise-encryptable'

group :production do
    gem "pg"
#   gem "mysql2"
end

#take out of assets https://github.com/rails/sass-rails/issues/38
gem 'sass-rails', :git => 'git://github.com/rails/sass-rails.git', :branch => '3-1-stable'

group :assets do 
  gem "coffee-rails", "~> 3.1.0"
  gem "uglifier"
end

group :development, :test do
  gem "rspec-rails"
  gem 'sqlite3'
end