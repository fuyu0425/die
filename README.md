# die: a paper template

## Start

### Prerequisites

- Python 3.x
- pygmentize

  ```sh
  pip install Pygments
  ```

- (Optional) [uv](https://docs.astral.sh/uv/): if installed, `make` auto-runs `uv sync` to set up `.venv`

- (Optional) [just](https://just.systems/): allows running build commands from any subdirectory via `just <target>`

- macOS ships with Make 3.81, which is too old for this Makefile.
  Install GNU Make via Homebrew and use `gmake` instead of `make`

  ```sh
  brew install make
  export PATH="$(brew --prefix)/opt/make/libexec/gnubin:$PATH"
  ```

### Clone the git repo

- If you have none:

  ```sh
  git clone --depth=1 git@github.com:fuyu0425/die.git
  ```

- If you have a git-repo to work on:

  ```sh
  git subtree add --squash git@github.com:fuyu0425/die.git master -P paper
  ```

### Build

```sh
make
# p.pdf built @Tue May 20 20:38:19 EDT 2014
# (check p.pdf)
```

### Starting point: `p.tex`

```sh
grep -oP 'input{\K\w+' p.tex
```

```
cmds
rev
*hdr
abstract
*ex
intro
overview
design
impl
eval
conclusion
ack
```

- `hdr`: includes title/author info
- `ex`: includes latex examples

### Example LaTeX

```sh
git checkout example
make
```

### Formatting rules (dependencies)

- `code/*.{c,cc,py,js,...}` → `code/*.tex`
- `fig/*.svg` → `fig/*.pdf`
- `data/*.gp` → `fig/*.tex`

See `ex.tex` for more details.

## Tools

1. Make a draft for revision

   ```sh
   make draft
   make watermark
   ```

2. `abstract.txt` (from `abstract.tex`)

   ```sh
   cat abstract.txt
   ```

3. Highlight changes since the last submit

   ```sh
   make diff DIFF=HEAD@{}
   ```

4. Spell check

   ```sh
   make spell
   ```

## Acknowledgment

This template contains a few files copied/stolen from the Internet and
mainly from my past collaborators (e.g., `sty/*`, `conf.bib`, some `bin/`),
which I couldn't keep track of their licenses.
