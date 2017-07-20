#!/bin/bash
if [[ -z "${DB_HOST}" ]]; then read -p "Enter database host: " DB_HOST; fi
if [[ -z "${DB_NAME}" ]]; then read -p "Enter database name: " DB_NAME; fi
if [[ -z "${ROOT_PATH}" ]]; then read -p "Enter ROOT PATH: " ROOT_PATH; fi

psql -h $DB_HOST -p 5432 -U postgres -v ON_ERROR_STOP=1 -v DB_NAME=$DB_NAME -v ROOT_PATH=$ROOT_PATH -f install_data.sql
