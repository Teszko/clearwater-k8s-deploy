#!/bin/bash

# append login information to auth_data.csv

auth_file="auth_data.csv"
number="$1"
password="$2"

if [ -z "$1" ] || [ -z "$2" ];
then
    echo "Usage: $0 <number> <password>"
    exit 1
fi

echo "$number;default.svc.cluster.local;[authentication username=$number@default.svc.cluster.local password=$password]" >> "$auth_file"

