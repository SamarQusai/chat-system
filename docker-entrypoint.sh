#!/bin/sh

set -e

if ! [ bundle check ]; then
   bundle install
fi

#Remove pre-existing server.pid for rails
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails db:create
bundle exec rails db:migrate

#Start Rails server
bundle exec rails s -p 3000 -b '0.0.0.0'