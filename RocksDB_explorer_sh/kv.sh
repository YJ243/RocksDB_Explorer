#!/bin/bash

DEV_PATH=$1
RESULT_PATH="../result_txt/"
KEY_SIZE=$2
VALUE_SIZE=$3
NUM=1000000
BENCHMARK=$4
a=16
b="_value"
c=64
d=".csv"
name=$a$b$c$d
print > $RESULT_PATH/key_value_size_result.txt
echo ========== key size = $KEY_SIZE, value size = $VALUE_SIZE =========== >> $RESULT_PATH/key_value_size_result.txt 
../db_bench --db=$DEV_PATH --use_direct_io_for_flush_and_compaction=true --benchmarks=$BENCHMARK --key_size=$KEY_SIZE --value_size=$VALUE_SIZE --num=$NUM --report_interval_seconds=1 --report_file=$name >> $RESULT_PATH/key_value_size_result.txt

