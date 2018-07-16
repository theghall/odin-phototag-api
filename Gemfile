source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.0'
# Use Puma as the app server
gem 'puma', '3.11'

# Allow cors
gem 'rack-cors', '1.0.2', require: 'rack/cors'

gem 'bootsnap', '1.3.0', require: false
# Because Heroku install fails otherwise
gem 'turbolinks', '5.1.1'
gem 'uglifier', '4.1.15'
# end Heroku required gems

# Database
gem 'pg', '1.0.0'
gem 'seedbank', '0.4.0'

# Serializer
gem 'active_model_serializers', '0.10.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', '1.8.7'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'minitest-reporters', '1.3.0'
  gem 'guard', '2.14.2'
  gem 'guard-minitest', '2.4.6'
end

