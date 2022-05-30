ROOT_PATH="/Users/antony/Code/MSU/Practicum/Hadoop/collaborative_filtering"


rm -r $ROOT_PATH/data/output/stage_4

mkdir $ROOT_PATH/data/output/stage_4

head -n100000 $ROOT_PATH/data/output/stage_3/part-00000 | \
    sort -k1,2n -t '@' | python3 $ROOT_PATH/src/reducer_4.py \
    > $ROOT_PATH/data/output/stage_4/part-00000