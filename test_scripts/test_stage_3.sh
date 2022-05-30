ROOT_PATH="/Users/antony/Code/MSU/Practicum/Hadoop/collaborative_filtering"


rm -r $ROOT_PATH/data/output/stage_3
mkdir $ROOT_PATH/data/output/stage_3


export mapreduce_map_input_file="$ROOT_PATH/data/output/stage_2/part-00000"
cat $mapreduce_map_input_file | \
    python3 $ROOT_PATH/src/mapper_3.py \
    > $ROOT_PATH/data/output/stage_3/temp.txt

export mapreduce_map_input_file="$ROOT_PATH/data/input/ratings.csv"
cat $mapreduce_map_input_file | \
    python3 $ROOT_PATH/src/mapper_3.py \
    >> $ROOT_PATH/data/output/stage_3/temp.txt
    
    
cat $ROOT_PATH/data/output/stage_3/temp.txt | sort -k1,2n -t '@' | \
    python3 $ROOT_PATH/src/reducer_3.py \
    > $ROOT_PATH/data/output/stage_3/part-00000