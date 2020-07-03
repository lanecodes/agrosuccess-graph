"""
check_lct_codes.py
~~~~~~~~~~~~~~~~~~

Work done in June 2020 to investigate the relationship between codes 3, 7, and
8 in the Millington 2009 supp. mat. The objective is to gain assurance over the
correct allocation of these state codes to the pasture, oak with pasture, and
cropland land-cover types.

All transitions from all of 3, 7, and 8 result in 5 (scrubland).

Conclude that 7 and 8 have the same transitions except all transitions in 7 are
secondary succession and all transitions in 8 are regeneration succession. 3
has all the transitions allowed by either 7 or 8. Based on this I think the
following mapping makes most sense:

    3 -> pasture as the lct is otherwise similar to the other two but we allow
         either regeneration or secondary succession to represent uncertainty
         about presence of regenerative vegetation.
    7 -> cropland as farmers would remove regenerative vegetative material so
         only secondary succession allowed.
    8 -> oak with pasture because it is known oak is present so we're confident
         we're on a regeneration pathway.
"""
import pandas as pd
import numpy as np

try:
    df = pd.read_csv('millington_succession.csv')
except FileNotFoundError:
    df = pd.read_csv('../data/tmp/millington_succession.csv')

managed_types = [3, 7, 8]
managed_df = (
    df[df['start'].isin(managed_types)]
    .sort_values(by=list(df.columns[:7]))
)

# 3 has twice as many pathways as 7 and 8 (96 compared to 48)
managed_df.groupby(by='start').size()

# 7 and 8 have the same transitions except 7 is all secondary succession (0)
# and 8 is all regeneration succession (1).
assert np.array_equal(
    (managed_df[managed_df['start'] == 7]
     .drop(columns=['start', 'succession']).values),
    (managed_df[managed_df['start'] == 8]
     .drop(columns=['start', 'succession']).values)
)

# Where 3 has secondary succession it has same transitions as 7
assert np.array_equal(
    (managed_df[(managed_df['start'] == 3) & (managed_df['succession'] == 0)]
     .drop(columns=['start']).values),
    (managed_df[managed_df['start'] == 7]
     .drop(columns=['start']).values)
)

# Where 3 has regeneration succession it has same transitions as 8
assert np.array_equal(
    managed_df[(managed_df['start'] == 3) & (managed_df['succession'] == 1)]
    .drop(columns=['start']).values,
    managed_df[managed_df['start'] == 8]
    .drop(columns=['start']).values
)
