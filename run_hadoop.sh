#!/bin/bash

SOURCE_BASE_PATH=""

# Input and output directories in HDFS
INPUT_HADOOP_DIR="/input"
OUTPUT_HADOOP_DIR="/output"

# Path to Hadoop Streaming jar
HADOOP_STREAMING_PATH="$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.1.jar"

# Remove HDFS input and output directories if present
hdfs dfs -rm -r $INPUT_HADOOP_DIR

# Copy input data to HDFS
hdfs dfs -put /data/input $INPUT_HADOOP_DIR

# Fix permissions for source code if necessary
chmod 0777 $SOURCE_BASE_PATH/src/mapper_*.py
chmod 0777 $SOURCE_BASE_PATH/src/reducer_*.py

# Remove Stage 1 output directory if present
hdfs dfs -rm -r $OUTPUT_HADOOP_DIR/stage_1

# Stage 1
hadoop jar $HADOOP_STREAMING_PATH \
  -D mapreduce.job.reduces=4 \
  -D stream.map.output.field.separator=@ \
  -D stream.num.map.output.key.fields=1 \
  -D stream.reduce.input.field.separator=@ \
  -files $SOURCE_BASE_PATH/src \
  -mapper src/mapper_1.py \
  -reducer src/reducer_1.py \
  -input $INPUT_HADOOP_DIR/ratings.csv \
  -output $OUTPUT_HADOOP_DIR/stage_1

# Remove Stage 2 output directory if present
hdfs dfs -rm -r $OUTPUT_HADOOP_DIR/stage_2

# Stage 2
hadoop jar $HADOOP_STREAMING_PATH \
  -D mapreduce.job.reduces=4 \
  -D stream.map.output.field.separator=@ \
  -D stream.num.map.output.key.fields=3 \
  -D mapreduce.map.output.key.field.separator=@ \
  -D mapreduce.partition.keypartitioner.options=-k1,2 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.partition.keycomparator.options="-k1,1n -k2,2n -k3,3n" \
  -D stream.reduce.input.field.separator=@ \
  -D mapreduce.map.memory.mb=512 \
  -D mapreduce.map.java.opts=-Xmx384m \
  -D mapreduce.reduce.memory.mb=256 \
  -D mapreduce.reduce.java.opts=-Xmx192m \
  -files $SOURCE_BASE_PATH/src \
  -mapper src/mapper_2.py \
  -reducer src/reducer_2.py \
  -input $OUTPUT_HADOOP_DIR/stage_1/part-* \
  -output $OUTPUT_HADOOP_DIR/stage_2 \
  -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

# Remove Stage 3 output directory if present
hdfs dfs -rm -r $OUTPUT_HADOOP_DIR/stage_3

# Stage 3
hadoop jar $HADOOP_STREAMING_PATH \
  -D mapreduce.job.reduces=4 \
  -D stream.map.output.field.separator=@ \
  -D stream.num.map.output.key.fields=2 \
  -D mapreduce.map.output.key.field.separator=@ \
  -D mapreduce.partition.keypartitioner.options=-k1,1 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.partition.keycomparator.options="-k1,1n -k2,2n" \
  -D stream.reduce.input.field.separator=@ \
  -D mapreduce.map.memory.mb=512 \
  -D mapreduce.map.java.opts=-Xmx384m \
  -D mapreduce.reduce.memory.mb=512 \
  -D mapreduce.reduce.java.opts=-Xmx384m \
  -files $SOURCE_BASE_PATH/src \
  -mapper src/mapper_3.py \
  -reducer src/reducer_3.py \
  -input $OUTPUT_HADOOP_DIR/stage_2/part-* $INPUT_HADOOP_DIR/ratings.csv \
  -output $OUTPUT_HADOOP_DIR/stage_3 \
  -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

# Remove Stage 4 output directory if present
hdfs dfs -rm -r $OUTPUT_HADOOP_DIR/stage_4

# Stage 4
hadoop jar $HADOOP_STREAMING_PATH \
  -D mapreduce.job.reduces=4 \
  -D stream.map.output.field.separator=@ \
  -D stream.num.map.output.key.fields=2 \
  -D mapreduce.map.output.key.field.separator=@ \
  -D stream.reduce.input.field.separator=@ \
  -D mapreduce.map.memory.mb=2049 \
  -D mapreduce.map.java.opts=-Xmx1024m \
  -D mapreduce.reduce.memory.mb=256 \
  -D mapreduce.reduce.java.opts=-Xmx192m \
  -files $SOURCE_BASE_PATH/src \
  -mapper src/mapper_4.py \
  -reducer src/reducer_4.py \
  -input $OUTPUT_HADOOP_DIR/stage_3/part-* \
  -output $OUTPUT_HADOOP_DIR/stage_4 \

# Remove Stage 5 output directory if present
hdfs dfs -rm -r $OUTPUT_HADOOP_DIR/stage_5

# Stage 5
hadoop jar $HADOOP_STREAMING_PATH \
  -D mapreduce.job.reduces=4 \
  -D stream.map.output.field.separator=@ \
  -D stream.num.map.output.key.fields=2 \
  -D mapreduce.map.output.key.field.separator=@ \
  -D mapreduce.partition.keypartitioner.options=-k1,1 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.partition.keycomparator.options="-k1,1n -k2,2n" \
  -D stream.reduce.input.field.separator=@ \
  -D mapreduce.map.memory.mb=512 \
  -D mapreduce.map.java.opts=-Xmx384m \
  -files $SOURCE_BASE_PATH/src \
  -mapper src/mapper_5.py \
  -reducer src/reducer_5.py \
  -input $OUTPUT_HADOOP_DIR/stage_4/part-* $INPUT_HADOOP_DIR/movies.csv \
  -output $OUTPUT_HADOOP_DIR/stage_5 \
  -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

# Remove Stage 6 output directory if present
hdfs dfs -rm -r $OUTPUT_HADOOP_DIR/stage_6

# Stage 6
hadoop jar $HADOOP_STREAMING_PATH \
  -D mapreduce.job.reduces=4 \
  -D stream.map.output.field.separator=@ \
  -D stream.num.map.output.key.fields=2 \
  -D mapreduce.map.output.key.field.separator=@ \
  -D mapreduce.partition.keypartitioner.options=-k1,1 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.partition.keycomparator.options="-k1,1n -k2,2nr" \
  -D stream.reduce.input.field.separator=@ \
  -D mapreduce.map.memory.mb=256 \
  -D mapreduce.map.java.opts=-Xmx192m \
  -files $SOURCE_BASE_PATH/src \
  -mapper src/mapper_6.py \
  -reducer src/reducer_6.py \
  -input $OUTPUT_HADOOP_DIR/stage_5/part-* \
  -output $OUTPUT_HADOOP_DIR/stage_6 \
  -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

# Copy output to namenode
hdfs dfs -get $OUTPUT_HADOOP_DIR $SOURCE_BASE_PATH/data/output
