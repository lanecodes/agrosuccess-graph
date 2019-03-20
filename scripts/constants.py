"""
constants.py
~~~~~~~~~~~~

Constants used in multiple scripts. Includes enumerators used to convert 
between numerical codes and human readable values.
"""
from enum import Enum, unique

@unique
class Succession(Enum):
    """Represents succession pathways. 
    
    Regeneration entails there is material in the landscape which resprouting 
    species can use to regenerate. Secondary succession is contrasted with 
    primary succession.
    """
    REGENERATION = 0
    SECONDARY = 1

    @property
    def alias(self):
        return str(self.name).lower()

@unique
class Aspect(Enum):
    """Binary aspect, which way slope of land faces."""
    NORTH = 0
    SOUTH = 1

    @property
    def alias(self):
        return str(self.name).lower()

@unique
class SeedPresence(Enum):
    """Presence of oak, pine, or deciduous seeds."""
    FALSE = 0
    TRUE = 1

    @property
    def alias(self):
        return str(self.name).lower()

@unique
class Water(Enum):
    """Discretisation of soil moisture levels."""
    XERIC = 0
    MESIC = 1
    HYDRIC = 2

    @property
    def alias(self):
        return str(self.name).lower()

@unique
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

    @property
    def alias(self):
        return str(self.name).lower()

@unique
class AgroSuccessLct(Enum):
    """Land cover types and corresponding codes used in AgroSuccess."""
    WATER_QUARRY = (0, "WaterQuarry")
    BURNT = (1, "Burnt")
    BARLEY = (2, "Barley")
    WHEAT = (3, "Wheat")
    DAL = (4, "DAL")
    SHRUBLAND = (5, "Shrubland")
    PINE = (6, "Pine")
    TRANS_FOREST = (7, "TransForest")
    DECIDUOUS = (8, "Deciduous")
    OAK = (9, "Oak")

    def __init__(self, code, alias):
        self._code = code
        self.alias = alias

    @property
    def value(self):
        return self._code

    @classmethod
    def _from_attr(cls, attr, value):
        matching_members = [member for name, member in cls.__members__.items()
                            if getattr(member, attr) == value]
        if not matching_members:
            raise ValueError("No member in {0} with value: {1}"\
                .format(cls, value))
        elif len(matching_members) > 1:
            raise ValueError("Multiple members in {0} with value: {1}"\
                .format(cls, value))
        else:
            return matching_members[0]

    @classmethod
    def from_alias(cls, value):
        return cls._from_attr("alias", value)

