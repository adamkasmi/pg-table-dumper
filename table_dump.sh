#!/bin/sh

# Script to dump a specific table from a PostgreSQL database.

# If you want to use password authentication without specifying the password in the command line,
# create a .pgpass file in the home directory of the user running this script with the following format:
# hostname:port:database:username:password
# For example: localhost:5432:mydb:myuser:mypass
# Ensure the file has correct permissions: chmod 600 ~/.pgpass

DB_NAME=$1
TABLE_NAME=$2
OUTPUT_FILE=$3

if [ -z "$DB_NAME" ] || [ -z "$TABLE_NAME" ] || [ -z "$OUTPUT_FILE" ]; then
    echo "Usage: $0 <db_name> <table_name> <output_file>"
    exit 1
fi

# Use pg_dump to extract the table.
pg_dump -d "$DB_NAME" -t "$TABLE_NAME" -f "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "Table $TABLE_NAME from $DB_NAME has been dumped to $OUTPUT_FILE"
else
    echo "Failed to dump the table. Check the provided database and table names, and ensure you have necessary permissions."
    exit 2
fi
