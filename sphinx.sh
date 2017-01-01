#!/bin/bash
# (c) 2016 Jim Fan
# Automate the document building process
#
git-add-doc() {
    git add *.html
    git add _static
    git add _sources
    git add _modules
    git add *.js
    git add *.inv
    touch .nojekyll # otherwise folders with underscore (_static) won't be loaded
    git add .nojekyll
    git commit -m 'Update github pages.'
    #git pusho origin gh-pages
}


case $1 in
c) # commit
    echo 'commit to gh-pages branch'
    git checkout gh-pages && git-add-doc
;;

d)
    echo shit
;;

*)
cd doc
make clean && make html
cd ..
open doc/build/html/index.html
;;
esac

