# README

## An APP about Volunteering

Our main goal is to build a place for Volunteering.

It'll be an webapp where institutions (nonprofit organizations) can add jobs and volunteers can subscribe to its jobs. Not only manage this subscriptions, we want to make a clear environment for both sides know better who wants to work and with which kind of company a people will work.

We ourselves are an open source project.

So, Welcome!

## Our technilogies

- Rails 
- Redis
- Docker
- Mailcatcher
- Postgresql


## First setup for running

At first, you need to setup some configurations after clonning the repo to your local machine.

### Create your own database.yml

On the repo we have a file _database-sample.yml_ on config dir. It's an sample to create your own. Please, don't delete it.

### Setup in your machine

 As we use docker, we have a _docker-compose.yml_ for it.
 
 If you want to use, your first step must be create your _database.yml_ with the following content
 
 ```yaml
 default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: postgres
  user: postgres

 development:
   <<: *default
   database: hack2save_development 

 test:
   <<: *default
   database: hack2save_test 

 ```
 
 After creating this file, run the following commands:
 
 ```sh
 1. docker-compose build
 2. docker-compose run --rm website bundle install
 3. docker-compose run --rm website bundle exec rails db:create
 4. docker-compose run --rm website bundle exec rails db:migrate
 5. docker-compose up
 ```
