#!/usr/bin/python3

import sys

title_tag = '0'
rating_tag = '1'

cur_movie = None
cur_title = None
for line in sys.stdin:
    movie, tag, *other = line.strip().split('@')
    if movie == cur_movie:
        user, rating = other
        print(f"{user}@{rating}@{movie}@{cur_title}")
    else:
        cur_movie = movie
        (cur_title,) = other
