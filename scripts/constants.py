"""
constants.py
~~~~~~~~~~~~

Constants used in multiple scripts. Includes enumerators used to convert 
between numerical codes and human readable values.
"""
from enum import Enum

class Succession(Enum):
    """Represents succession pathways. 
    
    Regeneration entails there is material in the landscape which resprouting 
    species can use to regenerate. Secondary succession is contrasted with 
    primary succession.
    """
    REGENERATION = 0
    SECONDARY = 1

class Aspect(Enum):
    """Binary aspect, which way slope of land faces."""
    NORTH = 0
    SOUTH = 1

class SeedPresence(Enum):
    """Presence of oak, pine, or deciduous seeds."""
    FALSE = 0
    TRUE = 1

class Water(Enum):
    """Discretisation of soil moisture levels."""
    XERIC = 0
    MESIC = 1
    HYDRIC = 2

class MillingtonLct(Enum):
    """Land cover types corresponding to James's PhD thesis.
    
    These are the codes which correspond to the transition table included in 
    the supplementary materials for Millington2009 paper.
    """
    PINE = 1
    TRANSITION_FOREST = 2
    DECIDUOUS = 3
    HOLM_OAK = 4
    PASTURE = 5
    HOLM_OAK_W_PASTURE = 6
    CROPLAND = 7
    SCRUBLAND = 8
    WATER_QUARRY = 9
    URBAN = 10
    BURNT = 11

class AgroSuccessLct(Enum):
    """Land cover types and corresponding codes used in AgroSuccess."""
    WATER_QUARRY = 0
    BURNT = 1
    BARLEY = 2
    WHEAT = 3
    DAL = 4
    SHRUBLAND = 5
    PINE = 6
    TRANS_FOREST = 7
    DECIDUOUS = 8
    OAK = 9  

