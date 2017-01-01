#!/bin/bash
cd doc
make clean && make html && open build/html/index.html
cd ..
