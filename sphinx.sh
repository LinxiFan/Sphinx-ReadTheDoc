#!/bin/bash
# (c) 2016 Jim Fan
# Automate the document building process
#

HTML_DIR=doc/build/html

trim() {
    echo -e "$1" | tr -d '[:space:]'
}

strlen() {
    echo -ne "$1" | wc -m
}

gh-pages-switch() {
    grep_output=$( git status -uno | grep 'nothing to commit' )
    # test empty string
    if [[ $grep_output = *[^[:space:]]* ]]; then
        git checkout gh-pages
    else
        echo ABORT: all changes must be commited before switching to "gh-pages" branch
        exit 1
    fi
}

gh-pages-commit() {
    gh-pages-switch
    echo 'Commit to gh-pages branch ...'
    if [ ! -d $HTML_DIR ]; then
        echo ABORT: $HTML_DIR does not exist. Run ./sphinx.sh first.
        git checkout master
        exit 1
    fi
    cp -rf $HTML_DIR/* .
    git add -f *.html
    git add -f _static
    git add -f _sources
    git add -f _modules
    git add -f *.js
    git add -f *.inv
    touch .nojekyll # otherwise folders with underscore (_static) won't be loaded
    git add -f .nojekyll
    git commit -m 'Update github pages.'
    git checkout master
}

gh-pages-push() {
    gh-pages-switch
    echo 'Push gh-pages to origin ...'
    git push origin gh-pages
    git checkout master
}

# ============== command line args ==============
case $1 in
c|commit) # commit
    gh-pages-commit
;;

p|push)
    gh-pages-push

;;

*) # run ./sphinx.sh without argument to build html 
cd doc
make clean && make html
cd ..
open doc/build/html/index.html
;;
esac

