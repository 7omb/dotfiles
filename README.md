# Dotfiles

Configuration files.

## Installation

Clone the repository and run the install script:

    git clone git://github.com/7omb/dotfiles
    cd dotfiles
    ./install

Open vim and run:

    :PlugInstall

## Vim dependencies

- Vim 8
- Python 3 with neovim
- ag
- ctags

Python:

    pip install jedi pylint

Haskell:

    stack install ghc-mod hlint hoogle

## Spacemacs dependencies

- ag
- shellcheck
- nodejs
- npm

Python:

    pip install flake8

Haskell:

    stack install hlint hasktags hoogle ghc-mod intero
    stack --resolver nightly-2017-01-06 install apply-refact

JavaScript:

    npm install -g tern
    npm install -g js-beautify
    npm install -g eslint
