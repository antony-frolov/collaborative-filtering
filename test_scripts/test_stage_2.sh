ROOT_PATH="/Users/antony/Code/MSU/Practicum/Hadoop/collaborative_filtering"


rm -r ${ROOT_PATH}/data/output/stage_2

mkdir ${ROOT_PATH}/data/output/stage_2

cat ${ROOT_PATH}/data/output/stage_1/part-00000 | python3 ${ROOT_PATH}/src/mapper_2.py | \
    sort -k1,3n -t '@' | python3 ${ROOT_PATH}/src/reducer_2.py \
    > ${ROOT_PATH}/data/output/stage_2/part-00000