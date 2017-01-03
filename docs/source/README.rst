GiTeX
=====

Generate LaTeX for Github markdown files.

|Python version| |Github release| |PyPI version| |PyPI status|

Dependency
----------

Add some math here :math:`\mu^\frac{\theta}{3}`, should work. Another
:math:`\sum_{i=0}^{\infty} f(i)` should \_work!

.. math::  \int_{\alpha}{\beta} \sum_{i} f(x) 

This package assumes that ``latex`` and ``dvipng`` commands are already
available in your system.

-  Mac users can install the dependencies with
   `MacTeX <http://www.tug.org/mactex/>`__.

-  Linux users can install with
   `TexLive <https://www.tug.org/texlive/>`__.

One-line command to install on Ubuntu:
``sudo apt-get install texlive-full dvipng``

-  Windows users please refer to this
   `manual <https://www.tug.org/texlive/windows.html>`__. Note that
   GiTeX has not been tested on Windows.

Installation
------------

``pip install gitex``

The installation includes both the ``gitex`` python3 library and two
command line executables.

Usage
-----

``>> tex2png``
~~~~~~~~~~~~~~

Converts short tex code to png on command line.

::

    usage: tex2png [-h] [-m MATH_MODE] [-d DPI] [-p PACKAGES] [-fg FOREGROUND]
                   [-bg BACKGROUND] [-O]
                   formula output_file

    positional arguments:
      formula               LaTeX formula text
      output_file           output png file

    optional arguments:
      -h, --help            show this help message and exit
      -m MATH_MODE, --math-mode MATH_MODE
                            LaTeX math mode: [inline, display, headless, none]
      -d DPI, --dpi DPI     Output resolution in DPI
      -p PACKAGES, --packages PACKAGES
                            `,` or `+` seperated list of LaTeX package names
                            additional to amsmath,amssymb, which are always
                            included.
      -fg FOREGROUND, --foreground FOREGROUND
                            Set the foreground color (rgb or CSS3 color name, e.g.
                            `gold`)
      -bg BACKGROUND, --background BACKGROUND
                            Set the background color (rgb or CSS3 color name, e.g.
                            `deepskyblue`)
      -O, --optimize        Optimize output image using `optipng`

``>> gitex``
~~~~~~~~~~~~

Compiles a GiTeX markdown into Github markdown with generated LaTeX
images.

::

    usage: GiTeX [-h] [-i IMAGE_FOLDER] [-r] [-d DPI] src_md output_md

    positional arguments:
      src_md                Source markdown file
      output_md             Output markdown file

    optional arguments:
      -h, --help            show this help message and exit
      -i IMAGE_FOLDER, --image-folder IMAGE_FOLDER
                            Folder for the generated latex images, must be
                            RELATIVE PATH with respect to your github dir.
      -r, --redraw          force all LaTeX formulas to redraw
      -d DPI, --dpi DPI     default global DPI for generated images

Python3 library
~~~~~~~~~~~~~~~

.. code:: python

    from gitex import tex2png # function API for `tex2png` command line script 
    from gitex import compile # function API for `gitex` command line script

.. |Python version| image:: https://img.shields.io/pypi/pyversions/GiTeX.svg
.. |Github release| image:: https://img.shields.io/github/release/LinxiFan/GiTeX.svg
.. |PyPI version| image:: https://img.shields.io/pypi/v/gitex.svg
.. |PyPI status| image:: https://img.shields.io/pypi/status/GiTeX.svg

