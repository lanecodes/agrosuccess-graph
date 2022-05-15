"""
constants.py
~~~~~~~~~~~~

Constants used in multiple scripts. Includes enumerators used to convert
between numerical codes and human readable values.
"""
from enum import Enum, unique

class AliasedEnum(Enum):
    """An enumeration whose values have a string alias.

    The alias for each enumeration constant is the enumeration constant itself
    in lower case.
    """

    @property
    def alias(self):
        return str(self.name).lower()


@unique
class Succession(AliasedEnum):
    """Represents succession pathways.

    Regeneration entails there is material in the landscape which resprouting
    species can use to regenerate. Secondary succession is contrasted with
    primary succession.
    """
    REGENERATION = 0
    SECONDARY = 1


@unique
class Aspect(AliasedEnum):
    """Binary aspect, which way slope of land faces."""
    NORTH = 0
    SOUTH = 1


@unique
class SeedPresence(AliasedEnum):
    """Presence of oak, pine, or deciduous seeds."""
    FALSE = 0
    TRUE = 1


@unique
class Water(AliasedEnum):
    """Discretisation of soil moisture levels."""
    XERIC = 0
    MESIC = 1
    HYDRIC = 2


@unique
class MillingtonThesisLct(AliasedEnum):
    """Land cover types corresponding to James's PhD thesis.

    These are the codes which correspond to Table 4.1 in James's PhD thesis.
    See documentation in `MillingtonPaperLct` for discussion of how these codes
    differ from those used in the supplementary materials oft the Millington
    2009 paper.
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


@unique
class MillingtonPaperLct(AliasedEnum):
    """Land cover types corresponding to supp. mat. in Millington et al. 2009.

    Note that this encoding differs from those used in James' PhD thesis (see
    `MillingtonThesisLct`). This follows discussion James and I had on
    2020-06-02 when we noticed that assuming the same encoding as the thesis
    for the transition rules in the paper's supplementary materials led to
    obvious errors, e.g. deciduous forest only transitioning to pasture. The
    work done to re-encode is summarised in the file
    ../data/raw/millington-land-cover-state-codes.csv.

    Using this encoding we can confirm that the transitions that are possible
    under the rules specified in the Millington et al. 2009 supp. mat., as well
    as the transition times, are compatible with those given in Table 4.1 in
    James's thesis. Note that the numerical state codes assigned to states in
    the thesis are not the same as those used in the long table in the
    Millington et al. 2009 supp. mat. For example, in James' thesis pasture
    has code 5, whereas in the Millington, 2009 supp. mat. it has code 3. The
    codes used in this enum correspond to those used in the long table in the
    paper's supplementary materials.

    See summarise_millington_table.py to compare the supp. mat. table with
    Table 4.1 in James's thesis.
    """
    PINE = 1
    TRANSITION_FOREST = 2
    PASTURE = 3
    DECIDUOUS = 4
    SCRUBLAND = 5
    HOLM_OAK = 6
    HOLM_OAK_W_PASTURE = 7
    CROPLAND = 8
    WATER_QUARRY = 9
    URBAN = 10
    BURNT = 11


@unique
class AgroSuccessLct(Enum):
    """Land cover types and corresponding codes used in AgroSuccess.

    Aliases do not correspond to lower case enumeration constants. This is to
    support consistency with the aliases used in the Java implementation of
    the AgroSuccess simulation model.
    """
    WATER_QUARRY = (0, "WaterQuarry")
    BURNT = (1, "Burnt")
    WHEAT = (2, "Wheat")
    DAL = (3, "DAL")
    SHRUBLAND = (4, "Shrubland")
    PINE = (5, "Pine")
    TRANS_FOREST = (6, "TransForest")
    DECIDUOUS = (7, "Deciduous")
    OAK = (8, "Oak")
    GRASSLAND = (9, "Grassland")

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
