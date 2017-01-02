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

# Append source code to a file. "EOT" can be an arbitrary string
append-extra-conf() {
	# make sure EXTRA_CONF is not appended twice
    grep_output=$( grep 'EXTRA CONF' $1 )
    # test empty string
    if [[ $grep_output = *[^[:space:]]* ]]; then
    	echo "ABORT: EXTRA CONF has already been appended to $1"
        exit 1
    fi

cat <<EOT >> $1  # append to file path indicated by $1
# ------------------ EXTRA CONF ------------------
import os
import sys
sys.path.insert(0, os.path.abspath('../../'))

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.napoleon',
    'sphinx.ext.mathjax',
    'sphinx.ext.ifconfig',
    'sphinx.ext.viewcode',
    'sphinx.ext.githubpages',
]
# Ensure HTTPS for correct mathjax rendering
mathjax_path = "https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"

# Napoleon settings
# http://www.sphinx-doc.org/en/1.5.1/ext/napoleon.html#configuration
napoleon_google_docstring = True
napoleon_numpy_docstring = False
napoleon_include_init_with_doc = False
napoleon_include_private_with_doc = False
napoleon_include_special_with_doc = True
napoleon_use_admonition_for_examples = False
napoleon_use_admonition_for_notes = False
napoleon_use_admonition_for_references = False
napoleon_use_ivar = False
napoleon_use_param = True
napoleon_use_rtype = True

# The suffix(es) of source filenames.
source_suffix = ['.rst', '.md']

# If true, todo and todoList produce output, else they produce nothing.
todo_include_todos = True

THEME = 'stanford'
if THEME == 'sphinx_rtd':
    import sphinx_rtd_theme
    html_theme = "sphinx_rtd_theme"
    html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
elif THEME == 'stanford':
    import stanford_theme
    html_theme = "stanford_theme"
    html_theme_path = [stanford_theme.get_html_theme_path()]
else:
    html_theme = "classic"

EXTRA_CSS = ''
def setup(app):
    "Defining setup(app) forces the script to load css"
    if EXTRA_CSS: 
        app.add_stylesheet(extra_css)

EOT
}

# ======================= command line args =======================
case $1 in
# >>> commit generated html to gh-pages branch
c|commit)
    gh-pages-commit
;;

# >>> push gh-pages branch to remote
push)
    gh-pages-push
;;

# >>> regenerate pydocs
p|py)
    if [ $# -lt 2 ]; then
        echo ABORT: ./sphinx.sh py "pkg_name"
        exit 1
    fi
    sphinx-apidoc --force -o doc/source/ ${@:2}
;;

# >>> append code to the end of "conf.py"
extra)
	append-extra-conf doc/source/conf.py
;;

# >>> run ./sphinx.sh without argument to build html 
*) 
cd doc
make clean && make html
cd ..
open doc/build/html/index.html
;;
esac

