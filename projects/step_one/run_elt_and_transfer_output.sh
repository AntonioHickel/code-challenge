#!/bin/bash

# Get the current date
current_date=$(date +%Y-%m-%d)

# Define the base output path
base_transfer_path="../../../data/postgres"

meltano el tap-postgres target-csv && meltano el tap-csv target-csv

cd ./output

for file in *.csv; do
    
    # Remove the prefix up to the first hyphen
    temp=${file#public-}

    # Remove the suffix starting from the next hyphen
    table=${temp%-*}

    transfer_path="$base_transfer_path/$table/$current_date"
    mkdir -p "$transfer_path"

    mv $file $transfer_path

done