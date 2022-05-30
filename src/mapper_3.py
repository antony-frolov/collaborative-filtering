#!/usr/bin/python3

import sys
import os

filename = os.environ['mapreduce_map_input_file'].split('/')[-1]

movie_tag = '0'
user_tag = '1'

for line in sys.stdin:
    if filename.startswith('part'):
        movie_rated, movie_comp, sim = line.strip().split('@')
        print(f"{movie_rated}@{movie_tag}@{movie_comp}@{sim}")
    elif filename.startswith('ratings'):
        user, movie_rated, rating, timestamp = line.strip().split(',')
        if user == 'userId':
            continue
        print(f"{movie_rated}@{user_tag}@{user}@{rating}")
