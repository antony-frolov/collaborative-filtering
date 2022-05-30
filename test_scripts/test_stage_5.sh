ROOT_PATH="/Users/antony/Code/MSU/Practicum/Hadoop/collaborative_filtering"


rm -r $ROOT_PATH/data/output/stage_5
mkdir $ROOT_PATH/data/output/stage_5


export mapreduce_map_input_file="$ROOT_PATH/data/output/stage_4/part-00000"
cat $mapreduce_map_input_file | \
    python3 $ROOT_PATH/src/mapper_5.py \
    > $ROOT_PATH/data/output/stage_5/temp.txt

export mapreduce_map_input_file="$ROOT_PATH/data/input/movies.csv"
cat $mapreduce_map_input_file | \
    python3 $ROOT_PATH/src/mapper_5.py \
    >> $ROOT_PATH/data/output/stage_5/temp.txt
    
    
cat $ROOT_PATH/data/output/stage_5/temp.txt | sort -k1,2n -t '@' | \
    python3 $ROOT_PATH/src/reducer_5.py \
    > $ROOT_PATH/data/output/stage_5/part-00000