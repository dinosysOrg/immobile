#!/bin/sh
psql -h localhost -p 5432 -d echoop -U postgres -v ON_ERROR_STOP=1 -f install_data.sql
