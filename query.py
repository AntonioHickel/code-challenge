import psycopg2
import json
from datetime import datetime

def default_converter(obj):
    """Convert non-serializable objects to a serializable format."""
    if isinstance(obj, datetime):
        return obj.isoformat()
    raise TypeError(f"Object of type {type(obj).__name__} is not JSON serializable")

# Database connection parameters
db_params = {
    'dbname': 'northwind',
    'user': 'northwind_user',
    'password': 'thewindisblowing',
    'host': 'db',
    'port': 5432
}

# SQL query to execute
query = """
    select * from tap_csv.orders o
    join tap_csv.order_details od on o.order_id=od.order_id;
"""
# File to save the JSON output
output_file = 'query_result.json'

try:
    # Connect to the database
    conn = psycopg2.connect(**db_params)

    # Create a cursor object
    cur = conn.cursor()

    # Execute the query
    cur.execute(query)

    # Fetch all rows from the query result
    rows = cur.fetchall()

    # Get column names
    col_names = [desc[0] for desc in cur.description]

    # Convert the query result to a list of dictionaries
    result = [dict(zip(col_names, row)) for row in rows]

    # Write the result to a JSON file, using the default_converter for non-serializable objects
    with open(output_file, 'w') as f:
        json.dump(result, f, default=default_converter, indent=4)

    # Close the cursor and the connection
    cur.close()
    conn.close()

    print(f"Query result has been saved to {output_file}")

except Exception as e:
    print(f"An error occurred: {e}")