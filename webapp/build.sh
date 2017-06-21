#!/bin/bash

bundle install
rake db:migrate
whenever --update-crontab

rails s -b 0.0.0.0 -p 8008 -e production -d
