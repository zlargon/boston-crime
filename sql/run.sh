#!/bin/bash

set -e

USER="root"   # Your Username
PASSWORD=""   # Your Passowrd

mysql --user="$USER" --password="$PASSWORD"       < create_crime_db.sql
mysql --user="$USER" --password="$PASSWORD" crime < import_from_csv.sql
mysql --user="$USER" --password="$PASSWORD" crime < crime_1NF.sql
