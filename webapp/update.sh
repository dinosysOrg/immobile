#!/bin/bash

git pull origin master

bundle update
bundle install

RAILS_ENV=production rake db:migrate

whenever --update-crontab

ps aux|grep 'rails'|grep -v 'grep'|awk '{ print $2 }'|xargs kill -9

rails s -b 0.0.0.0 -p 3000 -e production -d
