@echo off
setlocal enableextensions enabledelayedexpansion
SET /a "CURR_VERSION = 100"
SET /a "TARGET_VERSION = 114"

:WHILE
SET /a "CURR_VERSION += 1"
IF %CURR_VERSION% LEQ %TARGET_VERSION% (
    ECHO "Installing update/%CURR_VERSION%/000_update.sql"
    psql -h localhost -p 5432 -U postgres -v ON_ERROR_STOP=1 -f update/%CURR_VERSION%/000_update.sql
    GOTO :WHILE
)
endlocal
