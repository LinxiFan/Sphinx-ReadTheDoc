#!/bin/bash
cp -rf .nojekyll $1
cp -rf *.html $1
cp -rf *.js $1
cp -rf _static/ $1/_static
cp -rf _sources/ $1/_sources
cp -rf _modules/ $1/_modules
