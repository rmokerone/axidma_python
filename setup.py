#!/usr/bin/env python
# coding=utf-8
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

sourcefiles = ["axidma.pyx", "libaxidma/libaxidma.c", "libaxidma/libgpio.c"]

ext_modules = [
    Extension("axidma",
              sources=sourcefiles)]

setup(name="axidma", ext_modules=cythonize(ext_modules))
