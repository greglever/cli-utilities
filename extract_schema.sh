#!/bin/bash
#
# The idea is to extract the schema and check it is valid json using json.dumps in python
# This may result in a file you need to modify slightly first...
echo "import json" > run_this.py
awk '/_schemaSource = """/{flag=1; next}/"""/{print; flag=0}flag' $1 | awk '{if($1=="{\"namespace\":") print "json.dumps(\n"$0; else if ($1=="\"\"\"") print ")"; else print $0}' | awk '{if ($1==")") next ; else if ($1=="json.dumps(") print ") \n"$1; else print $0}' | tail -n +2 >> run_this.py
echo ")" >> run_this.py
PYTHONPATH=. python ./run_this.py
