# README

## Setup in your machine ##

 1. docker-compose build
 2. docker-compose run --rm website bundle install
 3. docker-compose run --rm website bundle exec rake db:create
 4. docker-compose run --rm website bundle exec rake db:migrate
 5. docker-compose up
