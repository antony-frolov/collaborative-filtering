#!/usr/bin/python3

import sys
import os

import csv

filename = os.environ['mapreduce_map_input_file'].split('/')[-1]

title_tag = '0'
rating_tag = '1'

for line in sys.stdin:
    if filename.startswith('part'):
        user, movie, rating = line.strip().split('@')
        print(f"{movie}@{rating_tag}@{user}@{rating}")
    elif filename.startswith('movies'):
        movie, title, genres = next(csv.reader([line.strip()]))
        if movie == 'movieId':
            continue
        print(f"{movie}@{title_tag}@{title}")
