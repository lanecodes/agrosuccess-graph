#! /home/andrew/anaconda2/envs/graphs27/bin/python

from cymod.transtable import EnvironTransitionSet
import pandas as pd

ets = EnvironTransitionSet(pd.read_pickle('traj.pkl'), 'start_code',
                           'end_code', 'delta_T')

env_cond_aliases = {'succession': {0: 'regeneration', 1: 'secondary'},
                    'aspect': {0: 'north', 1: 'south'},
                    'pine': {0: False, 1: True},
                    'oak': {0: False, 1: True},
                    'deciduous': {0: False, 1: True},
                    'water': {0: 'xeric', 1: 'mesic', 2: 'hydric'}
                    }

ets.apply_environ_condition_aliases(env_cond_aliases)
ets.write_cypher_files('../views')
