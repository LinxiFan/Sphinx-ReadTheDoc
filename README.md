`sphinx.sh` takes care of everything, from setting up to committing and pushing to Github. 

```bash
usage: ./sphinx.sh <command> <args...>
start:      automate "sphinx-quickstart" command
    args: <project_name> "<authors>" <version>
extra:      append extra config code to the end of "docs/source/conf.py"
p|py:       regenerate pydocs
    args: <package_name>
c|commit:   commit generated html to "gh-pages" branch
push:       push "gh-pages" branch to remote
<empty>:    run ./sphinx.sh without args to build html
```
