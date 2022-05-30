#!/usr/bin/python3

import sys

import numpy as np


def adj_cosine_similarity(a, b):
    sim = (a * b).sum() / np.sqrt((a ** 2).sum()) / np.sqrt((b ** 2).sum())
    return max(sim, 0)


cur_movie_pair = None
cur_diff1s = []
cur_diff2s = []
for line in sys.stdin:
    movie1, movie2, user, diff1, diff2 = line.strip().split('@')
    if (movie1, movie2) == cur_movie_pair:
        cur_diff1s.append(float(diff1))
        cur_diff2s.append(float(diff2))
    else:
        if cur_movie_pair is not None:
            a, b = np.array(cur_diff1s), np.array(cur_diff2s)
            sim = adj_cosine_similarity(a, b)
            if sim > 0:
                print(f"{'@'.join(cur_movie_pair)}@{sim:.3f}")
        cur_movie_pair = (movie1, movie2)
        cur_diff1s = [float(diff1)]
        cur_diff2s = [float(diff2)]

if cur_movie_pair is not None:
    a, b = np.array(cur_diff1s), np.array(cur_diff2s)
    sim = adj_cosine_similarity(a, b)
    if sim > 0:
        print(f"{'@'.join(cur_movie_pair)}@{sim:.3f}")
