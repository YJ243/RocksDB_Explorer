#!/bin/bash

DEV_PATH="../mnt"
RESULT_PATH="../result_txt/"
NUM=5000000
BENCHMARK="fillrandom,levelstats,stats"
RESULT_FILE="fillrandom_key"
RESULT_FILE2="readrandom_key"
R="_value"

key_vars=( 16 32 64 128 245 1024 )
value_vars=( 256 512 1024 4096 16384 )

for k in ${key_vars[@]};
do
	for v in ${value_vars[@]};
	do
		BENCHMARK=fillrandom,levelstats,stats
		#bench1 : fillrandom
		#Result File : "fillrandom_key_value.txt"
		print > $RESULT_PATH/$RESULT_FILE$k$R$v.txt
		echo ==========fillrandom: key size = $k, value size = $v ================ >> $RESULT_PATH/$RESULT_FILE$k$R$v.txt
		../db_bench --db=$DEV_PATH --use_direct_io_for_flush_and_compaction=true --benchmarks=$BENCHMARK --key_size=$k --value_size=$v --num=$NUM --statistics >> $RESULT_PATH/$RESULT_FILE$k$R$v.txt
		BENCHMARK=readrandom,levelstats,stats
		#bench2 : readrandom
		#Result File : "readrandom_key_value.txt"
		print > $RESULT_PATH/$RESULT_FILE2$k$R$v.txt
		echo ==========readrandom: key size = $k, value size = $v ================ >> $RESULT_PATH/$RESULT_FILE$k$R$v.txt
		../db_bench --db=$DEV_PATH --use_direct_io_for_flush_and_compaction=true --use_direct_reads=true --benchmarks=$BENCHMARK --key_size=$k --value_size=$v --num=$NUM --statistics --use_existing_db >> $RESULT_PATH/$RESULT_FILE2$k$R$v.txt
	done
done

echo "********* Bench Fin **********"

i="_v"
PARSER="../python_parser"

for k in ${key_vars[@]};
do	
	for v in ${value_vars[@]}
	do
		python3 $PARSER/compaction_parser.py $RESULT_PATH/$RESULT_FILE$k$R$v.txt $PARSER/csv/k$k$i$v.csv
		python3 $PARSER/compaction_parser.py $RESULT_PATH/$RESULT_FILE2$k$R$v.txt $PARSER/csv/k$k$i$v.csv
		python3 $PARSER/99parser.py $RESULT_PATH/$RESULT_FILE$k$R$v.txt $PARSER/csv/k$k$i$v.csv
		python3 $PARSET/99parser.py $RESULT_PATH/$RESULT_FILE$k$R$v.txt $PARSER/csv/k$k$i$v.csv
	done
done

echo "********* parser Fin *********"
		
