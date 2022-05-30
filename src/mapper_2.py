#!/usr/bin/python3

import sys

from itertools import combinations


for line in sys.stdin:
    user, *movie_diff_list = line.strip().split('@')
    movie_diff_list = [movie_diff.split('%') for movie_diff in movie_diff_list]
    for (movie1, diff1), (movie2, diff2) in combinations(movie_diff_list, 2):
        print(f"{movie1}@{movie2}@{user}@{diff1}@{diff2}")
