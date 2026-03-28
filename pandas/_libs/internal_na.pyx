from cpython.object cimport PyObject, PyTypeObject, PyObject_TypeCheck

cdef public bint pandas_internal_is_NA(PyObject* obj):
    na_type = <PyTypeObject*>C_NAType;
    assert na_type != NULL

    return PyObject_TypeCheck(<object>obj, na_type) != 0

def internal_is_NA(o):
    return pandas_internal_is_NA(<PyObject*>o)
