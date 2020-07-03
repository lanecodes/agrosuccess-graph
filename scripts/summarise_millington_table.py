import os

import pandas as pd

from config import DIRS


def summarise_millington_succession():
    """Summary table of possible transitions between land-cover states.

    Shows which start and end states are possible, and what the range in time
    periods for these transitions to occur under different environmental
    conditions are.
    """
    return (
        pd.read_csv(os.path.join(DIRS['data']['tmp'],
                                 'millington_succession.csv'))
        .pipe(lambda df: df[df['start'] != df['delta_D']])
        .groupby(by=['start', 'delta_D'])
        .agg(min_delta_T=pd.NamedAgg(column='delta_T', aggfunc='min'),
             max_delta_T=pd.NamedAgg(column='delta_T', aggfunc='max'))
    )


if __name__ == '__main__':
    summary_file = os.path.join(DIRS['data']['tmp'],
                                'millington_summary_table.csv')
    summarise_millington_succession().to_csv(summary_file, header=True)
