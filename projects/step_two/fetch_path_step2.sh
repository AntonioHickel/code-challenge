#!/bin/bash

# Get the current date
current_date=$(date +%Y-%m-%d)

# Define the base output path
base_output_path="../../data/postgres"
cd $base_output_path

# Set the output directory environment variable
cd categories/$current_date
csv_file=$(ls *.csv | head -n 1)
export TAP_CSV_CATEGORIES_PATH="$base_output_path/categories/$current_date/$csv_file"

cd ../../customers/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_CUSTOMERS_PATH="$base_output_path/customers/$current_date/$file_name"

cd ../../employee_territories/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_EMPLOYEE_TERRITORIES_PATH="$base_output_path/employee_territories/$current_date/$file_name"

cd ../../employees/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_EMPLOYEES_PATH="$base_output_path/employees/$current_date/$file_name"

cd ../../order_details/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_ORDER_DETAILS_PATH="$base_output_path/order_details/$current_date/$file_name"

cd ../../shippers/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_SHIPPERS_PATH="$base_output_path/shippers/$current_date/$file_name"

cd ../../suppliers/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_SUPPLIERS_PATH="$base_output_path/suppliers/$current_date/$file_name"

cd ../../territories/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_TERRITORIES_PATH="$base_output_path/territories/$current_date/$file_name"

cd ../../us_states/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_US_STATES_PATH="$base_output_path/us_states/$current_date/$file_name"

cd ../../orders/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_ORDERS_PATH="$base_output_path/orders/$current_date/$file_name"

cd ../../products/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_PRODUCTS_PATH="$base_output_path/products/$current_date/$file_name"

cd ../../region/$current_date
file_name=$(ls *.csv | head -n 1)
export TAP_CSV_REGION_PATH="$base_output_path/region/$current_date/$file_name"

cd ../../../../projects/step_two

meltano el tap-csv target-postgres