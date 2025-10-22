if (
    convert_to_nullable_dtype
    or (uints > SAFE_UINT64_MAX).any()
    or (np.absolute(ints) > SAFE_UINT64_MAX).any()
):
    # Below we will wrap in IntegerArray
    if seen.uint_:
        result = uints
    else:
        result = ints
