ROOT_PATH="/Users/antony/Code/MSU/Practicum/Hadoop/collaborative_filtering"


rm -r $ROOT_PATH/data/output/stage_6

mkdir $ROOT_PATH/data/output/stage_6

cat $ROOT_PATH/data/output/stage_5/part-00000 | \
    sort -k1,2n -t '@' | python3 $ROOT_PATH/src/reducer_6.py \
    > $ROOT_PATH/data/output/stage_6/part-00000