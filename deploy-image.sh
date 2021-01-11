#! /bin/bash

# Require a .env file:
# HEROKU_API_KEY='apikey'
# HEROKU_APP='heroku-app-name'

export $(grep -v '^#' .env | xargs);

docker login --username=_ --password=$HEROKU_API_KEY registry.heroku.com;

docker build image -t registry.heroku.com/$HEROKU_APP/web;

docker push registry.heroku.com/$HEROKU_APP/web;

heroku container:release web -a $HEROKU_APP;