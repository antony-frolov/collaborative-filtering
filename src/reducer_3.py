#!/usr/bin/python3

import sys

from itertools import product

movie_tag = '0'
user_tag = '1'

cur_movie_rated = None
cur_movie_sim_list = []
cur_user_rating_list = []
for line in sys.stdin:
    movie_rated, tag, *other = line.strip().split('@')
    if movie_rated == cur_movie_rated:
        if tag == movie_tag:
            movie_comp, sim = other
            cur_movie_sim_list.append((movie_comp, sim))
        elif tag == user_tag:
            user, rating = other
            cur_user_rating_list.append((user, rating))
    else:
        if cur_movie_rated is not None:
            for (movie_comp, sim), (user, rating) in product(cur_movie_sim_list, cur_user_rating_list):
                print(f"{user}@{movie_comp}@{movie_rated}@{sim}@{rating}")
            for user, rating in cur_user_rating_list:
                print(f"{user}@{movie_rated}@{movie_rated}@1@{rating}")
        cur_movie_rated = movie_rated
        if tag == movie_tag:
            movie_comp, sim = other
            cur_movie_sim_list = [(movie_comp, sim)]
            cur_user_rating_list = []
        elif tag == user_tag:
            user, rating = other
            cur_movie_sim_list = []
            cur_user_rating_list = [(user, rating)]

if cur_movie_rated is not None:
    for (movie_comp, sim), (user, rating) in product(cur_movie_sim_list, cur_user_rating_list):
        print(f"{user}@{movie_comp}@{movie_rated}@{sim}@{rating}")
