#!/usr/bin/python3

import sys


def zipjoin(a, b):
    return '@'.join(f"{x}%{y}" for x, y in zip(a, b))


cur_user = None
cur_ratings = []
cur_movies = []
cur_titles = []
cur_cnt = 0
for line in sys.stdin:
    user, rating, movie, title = line.strip().split('@')
    if user == cur_user and cur_cnt < 100:
        cur_ratings.append(rating)
        cur_movies.append(movie)
        cur_titles.append(title)
        cur_cnt += 1
    elif user != cur_user:
        if cur_user is not None:
            print(f"{cur_user}@{zipjoin(cur_ratings, cur_titles)}")
        cur_user = user
        cur_ratings = [rating]
        cur_movies = [movie]
        cur_titles = [title]
        cur_cnt = 1

if cur_user is not None:
    print(f"{cur_user}@{zipjoin(cur_ratings, cur_titles)}")
