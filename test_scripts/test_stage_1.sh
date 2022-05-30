ROOT_PATH="/Users/antony/Code/MSU/Practicum/Hadoop/collaborative_filtering"


rm -r ${ROOT_PATH}/data/output/stage_1

mkdir ${ROOT_PATH}/data/output/stage_1

cat ${ROOT_PATH}/data/input/ratings_sample.csv | python3 ${ROOT_PATH}/src/mapper_1.py | \
    sort -k1,1n -t '@' | python3 ${ROOT_PATH}/src/reducer_1.py \
    > ${ROOT_PATH}/data/output/stage_1/part-00000