# Dotfiles

Configuration files.

## Installation

Clone the repository and run the install script:

    git clone git://github.com/7omb/dotfiles
    cd dotfiles
    ./install

## Syncing org files

Clone [git-sync](https://github.com/simonthum/git-sync) and add it to the PATH.
Afterwards the service and timer can be enabled by:

    systemctl --user enable /path/to/git-sync.service
    systemctl --user enable /path/to/git-sync.timer
    systemctl --user link /path/to/failure-popup@.service

The status can be checked with:

    systemctl --user status /path/to/git-sync.service

Error popups can be tested with:

    systemctl --user start failure-popup@git-sync.service

TODO: Popups only support KDE right now
