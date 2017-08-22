#!/bin/bash

git pull origin master

bundle update
bundle install

RAILS_ENV=production rake db:migrate

whenever --update-crontab

ps aux|grep 'puma'|grep -v 'grep'|awk '{ print $2 }'|xargs kill -9

bundle exec rake assets:precompile
rails s -b 0.0.0.0 -p 3000 -e production -d
