#!/usr/bin/python3

import sys


def zipjoin(a, b):
    return '@'.join(f"{x}%{y}" for x, y in zip(a, b))


cur_user = None
cur_ratings = []
cur_movies = []
for line in sys.stdin:
    user, movie, rating = line.strip().split('@')
    if user == cur_user:
        cur_ratings.append(float(rating))
        cur_movies.append(movie)
    else:
        if cur_user is not None:
            mean_rating = sum(cur_ratings) / len(cur_ratings)
            diffs = (f"{rating - mean_rating:.3f}" for rating in cur_ratings)
            print(f"{cur_user}@{zipjoin(cur_movies, diffs)}")
        cur_user = user
        cur_ratings = [float(rating)]
        cur_movies = [movie]

if cur_user is not None:
    mean_rating = sum(cur_ratings) / len(cur_ratings)
    diffs = (f"{rating - mean_rating:.3f}" for rating in cur_ratings)
    print(f"{cur_user}@{zipjoin(cur_movies, diffs)}")
