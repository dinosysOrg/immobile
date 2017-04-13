#!/bin/sh
CURR_VERSION=100
TARGET_VERSION=101

while [ $CURR_VERSION -lt $TARGET_VERSION ]
do
    CURR_VERSION=$(( CURR_VERSION+1 ))
    echo "Installing update/$CURR_VERSION/000_update.sql"
    psql -h localhost -p 5432 -U postgres -v ON_ERROR_STOP=1 -f update/$CURR_VERSION/000_update.sql
done
