#!/bin/bash

DEV_PATH=$1
RESULT_PATH="../result_txt/"
KEY_SIZE=$2
VALUE_SIZE=$3
NUM=5000000
BENCHMARK=$4

print > $RESULT_PATH/key_value_size_result_existingdb.txt
echo ========== key size = $KEY_SIZE, value size = $VALUE_SIZE =========== >> $RESULT_PATH/key_value_size_result_existingdb.txt 
../db_bench --db=$DEV_PATH --use_direct_io_for_flush_and_compaction=true --benchmarks=$BENCHMARK --key_size=$KEY_SIZE --value_size=$VALUE_SIZE --statistics --num=$NUM --use_existing_db >> $RESULT_PATH/key_value_size_result_existingdb.txt

