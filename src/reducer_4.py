#!/usr/bin/python3

import sys

import numpy as np


def compute_rating(sims, ratings):
    return (sims * ratings).sum() / sims.sum()


cur_user_movie_comp = None
cur_sims = []
cur_ratings = []
cur_movies_rated = []
for line in sys.stdin:
    user, movie_comp, movie_rated, sim, rating = line.strip().split('@')
    if (user, movie_comp) == cur_user_movie_comp:
        cur_sims.append(float(sim))
        cur_ratings.append(float(rating))
        cur_movies_rated.append(movie_rated)
    else:
        if (cur_user_movie_comp is not None and
                movie_comp not in cur_movies_rated):
            rating = compute_rating(np.array(cur_sims), np.array(cur_ratings))
            print(f"{'@'.join(cur_user_movie_comp)}@{rating:.3f}")
        cur_user_movie_comp = user, movie_comp
        cur_sims = [float(sim)]
        cur_ratings = [float(rating)]
        cur_movies_rated = [movie_rated]

if (cur_user_movie_comp is not None and
        movie_comp not in cur_movies_rated):
    rating = compute_rating(np.array(cur_sims), np.array(cur_ratings))
    print(f"{'@'.join(cur_user_movie_comp)}@{rating:.3f}")
