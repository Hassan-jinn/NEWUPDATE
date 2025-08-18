from distutils.core import setup
from Cython.Build import cythonize
from Cython.Distutils import build_ext

setup(
    name='WALEEDXD_OPTIMIZED',
    cmdclass={'build_ext': build_ext},
    ext_modules=cythonize(
        "WALEEDXD_OPTIMIZED.pyx",
        compiler_directives={
            'language_level': "3",
            'boundscheck': False,
            'wraparound': False,
            'initializedcheck': False,
            'nonecheck': False,
            'cdivision': True,
            'infer_types': True
        }
    )
)