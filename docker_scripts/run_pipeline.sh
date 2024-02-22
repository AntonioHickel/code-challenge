#!/bin/bash

cd ../

export PIPELINE_HOME=$PWD

cd projects/step_one/ && chmod +x run_elt_and_transfer_output.sh && cd ../..
cd projects/step_two/ && chmod +x fetch_path_step2.sh && cd ../..

source airflow_venv/bin/activate

(airflow webserver -p 8080 &)

airflow dags pause run_elt_and_transfer_output
airflow dags pause fetch_path_step2

STEP_ONE_ACTIVATED=false
STEP_TWO_ACTIVATED=false

# Parse arguments
for arg in "$@"
do
    case $arg in
        --step_one)
            STEP_ONE_ACTIVATED=true
            airflow dags unpause run_elt_and_transfer_output
            shift
            ;;
        --step_two)
            STEP_TWO_ACTIVATED=true
            airflow dags unpause fetch_path_step2
            shift
            ;;
        --start_date*)
            IFS='--' read -ra ADDR <<< "$arg"
            DATE="${ADDR[2]}"
            IFS='-' read -ra DATE_PARTS <<< "$DATE"
            if [ "$STEP_ONE_ACTIVATED" = true ]; then
                export MONTH1="${DATE_PARTS[0]}"
                export DAY1=$((${DATE_PARTS[1]} - 1))
                export YEAR1="${DATE_PARTS[2]}"
            fi
            if [ "$STEP_TWO_ACTIVATED" = true ]; then
                export MONTH2="${DATE_PARTS[0]}"
                export DAY2=$((${DATE_PARTS[1]} - 1))
                export YEAR2="${DATE_PARTS[2]}"
            fi
            shift
            ;;
        --now)
            if [ "$STEP_ONE_ACTIVATED" = true ]; then
                airflow dags trigger run_elt_and_transfer_output
            fi
            if [ "$STEP_TWO_ACTIVATED" = true ]; then
                airflow dags trigger fetch_path_step2
            fi
            shift
            ;;
    esac
done

# Set default start date if not provided
if [ -z "$MONTH1" ] && [ "$STEP_ONE_ACTIVATED" = true ]; then
    export MONTH1=$(date +%m)
    export DAY1=$(($(date +%d) - 1))
    export YEAR1=$(date +%Y)
fi

if [ -z "$MONTH2" ] && [ "$STEP_TWO_ACTIVATED" = true ]; then
    export MONTH2=$(date +%m)
    export DAY2=$(($(date +%d) - 1))
    export YEAR2=$(date +%Y)
fi

airflow scheduler