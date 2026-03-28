import pytest

from pandas._libs.internal_na import internal_is_NA, C_NAType
from pandas import NA
import numpy as np


def test_NA():
    assert isinstance(NA, C_NAType)
    assert internal_is_NA(NA)


@pytest.mark.parametrize(
    "obj",
    [
        None,
        0,
        False,
        float("inf"),
        -float("inf"),
        float(0),
        -float(0),
        np.nan,
        np.inf,
        -np.inf,
        "",
        b"",
        [],
        (),
        {},
        set(),
        type,
    ],
)
def test_not_NA(obj):
    assert not internal_is_NA(obj)
