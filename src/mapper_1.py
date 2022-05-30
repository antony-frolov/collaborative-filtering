#!/usr/bin/python3

import sys

for line in sys.stdin:
    user, movie, rating, _ = line.strip().split(',')
    if user == 'userId':
        continue
    print(f"{user}@{movie}@{rating}")
