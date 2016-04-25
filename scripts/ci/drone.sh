#!/bin/bash

set -e

echo "Setting up database.yml"

echo "  host: 127.0.0.1" >> config/database.yml.ci
echo "  username: postgres" >> config/database.yml.ci
echo "  password: exsules" >> config/database.yml.ci

cp config/database.yml.ci config/database.yml
cp config/exsules.yml.example config/exsules.yml
cp config/secrets.yml.example config/secrets.yml
