##############################################
Documentation using Sphinx and ReadTheDocs.org
##############################################


For documentation, we'll use **Sphinx** to generate it, and **Read the Docs**
to publish it. GitHub will be a helpful middleman.

Set up your working environment
===============================

reStructuredText elements
-------------------------

.. warning::
    Warning directive, similar colors apply to
    ``.caution, .attention``

        WARNING: toctree contains reference to nonexisting document u'all-about-me'
        ...
        checking consistency...
        <your repository>/my-first-docs/docs/all-about-me.rst::
        WARNING: document isn't included in any toctree

    Quite likely, what has happened here is that you indented ``all-about-me``
    in your ``.. toctree::`` with *four* spaces, when Sphinx is expecting
    *three*.


.. tip::
    This is a tip directive. Similar colors apply to
    ``.hint``

.. danger::
    This is a danger directive. Similar colors apply to 
    ``.important, .error``

.. seealso::
    This is a See Also directive.
    

.. hint::
    This is a tip directive. Similar colors apply to
    ``.hint``

.. important::
    This is a danger directive. Similar colors apply to 
    ``.important, .error``

The virtualenv
--------------

As usual, create and activate a new virtualenv::

    virtualenv documentation-tutorial
    [...]
    cd documentation-tutorial/
    source bin/activate


The package or project
----------------------

If you have an existing package to write documentation for
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your package is on GitHub already and you want to start writing documention
for, clone it now using Git. And of course, start a new branch::

    git checkout -b first-docs

You can merge your docs into your master branch when they start to look
respectable.

If you don't have an existing package that needs docs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you don't have a suitable existing package on GitHub, create
a repository on GitHub the way you did before. Call it ``my-first-docs``. Then
create a Git repository locally::

    mkdir my-first-docs
    cd my-first-docs/
    # Converts the directory into a git repository
    git init
    # Point this repo at the GitHub repo you just created
    git remote add origin git@github.com:<your git username>/my-first-docs.git
    # Create a new branch in which to do your work
    git checkout -b first-docs


Sphinx
======

Install Sphinx
--------------

::

    pip install sphinx

It might take a minute or so, it has quite a few things to download and install.

sphinx-quickstart
-----------------

``sphinx-quickstart`` will set up the source directory for your documentation.
It'll ask you a number of questions. Mostly you can just accept the defaults
it offers, and some are just obvious, but there are some you will want to set
yourself as noted below::

    sphinx-quickstart

Root path for the documentation
    ``docs``

Project name
    ``<your name>'s first docs``, or the name of your application

Source file suffix
    ``.rst`` is the default. (Django's own documentation uses ``.txt``. It
    doesn't matter too much.)

You'll find a number of files in your ``docs`` directory now, including
``index.rst``. Open that up.


Using Sphinx & reStructuredText
===============================

Create a new page
-----------------

You have no other pages yet. In the same directory as ``index.rst``, create
one called ``all-about-me.rst`` or something appropriate. Perhaps it might
look like::


    ############
    All about me
    ############

    I'm Daniele Procida, a Django user and developer.

    I've contributed to:

    *   django CMS
    *   Arkestra
    *   Django

Sphinx needs to know about it, so in ``index.rst``, edit the ``.. toctree::``
section to add the ``all-about-me`` page::

    .. toctree::
       :maxdepth: 2

       all-about-me

Save both pages.

Render your documentation
-------------------------

In the ``docs`` directory::

    make html

This tells Sphinx to render your source pages. *Pay attention to its warnings*
- they're helpful!

.. note::
    Sphinx can be fussy, and sometimes about things you weren't expecting. For
    example, you well encounter something like::

        WARNING: toctree contains reference to nonexisting document u'all-about-me'
        ...
        checking consistency...
        <your repository>/my-first-docs/docs/all-about-me.rst::
        WARNING: document isn't included in any toctree

    Quite likely, what has happened here is that you indented ``all-about-me``
    in your ``.. toctree::`` with *four* spaces, when Sphinx is expecting
    *three*.

If you accepted the ``sphinx-quickstart`` defaults, you'll find the rendered
pages in ``docs/_build/html``. Open the ``index.html`` it has created in your
browser. You should find in it a link to your new ``all-about-me`` page too.

Publishing your documentation
=============================

Exclude unwanted rendered directories
-------------------------------------

Remember ``.gitignore``? It's really useful here, because you don't want to
commit your *rendered* files, just the source files.

In my ``.gitignore``, I make sure that directories I don't want committed are
listed. Check that::

    _build
    _static
    _templates

are listed in ``.gitignore``.


readthedocs.org
---------------

However, we want to get them onto Read the Docs. So go to
https://readthedocs.org, and sign up for an account if you don't have one.

You need to **Import** a project: https://readthedocs.org/dashboard/import/.

Give it the details of your GitHub project in the **repo** field -
``git@github.com:<your git username>/my-first-docs.git``, or whatever it is -
and hit **Create**.

And now Read the Docs will actually watch your GitHub project, and build,
render and host your documents for you automatically.

It will update every night, but you can do better still: on GitHub:

#.  select **settings** for your project (not for your account) in the
    navigation panel on the right-hand side
#.  choose **Webhooks & Services**
#.  enable ``ReadTheDocs`` under **Add Service** dropdown

... and now, every time you push documents to GitHub, Read the Docs will be
informed that you have new documents to be published. It's not magic, but it's
pretty close.
