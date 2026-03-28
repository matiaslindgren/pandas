import re

import numpy as np
import pytest

import pandas as pd
from pandas import (
    DataFrame,
    DatetimeIndex,
    Index,
    MultiIndex,
    Series,
    Timestamp,
)
import pandas._testing as tm


@pytest.fixture(params=tm.FLOAT_EA_DTYPES)
def any_numeric_ea_dtype(request):
    return request.param


class TestDataFrameDrop:
    @pytest.mark.parametrize("idx, level", [(["a", "b"], 0), (["a"], None)])
    def test_drop_index_ea_dtype(self, any_numeric_ea_dtype, idx, level):
        # GH#45860
        df = DataFrame(
            {"a": [1, 2, 2, pd.NA], "b": 100}, dtype=any_numeric_ea_dtype
        ).set_index(idx)
        result = df.drop(Index([2, pd.NA]), level=level)
        expected = DataFrame(
            {"a": [1], "b": 100}, dtype=any_numeric_ea_dtype
        ).set_index(idx)
        tm.assert_frame_equal(result, expected)
