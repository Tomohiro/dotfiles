dotfiles
================================================================================

[![Build Status](https://img.shields.io/travis/Tomohiro/dotfiles.svg?style=flat-square)](https://secure.travis-ci.org/Tomohiro/dotfiles)


Installation
--------------------------------------------------------------------------------

```sh
$ git submodule update
$ make install
```


Add submodules
--------------------------------------------------------------------------------

```sh
$ git submodule add git@github.com:johndoe/foo-command bundle/foo-command
$ git commit -m 'add foo-command' .gitmodules bundle/foo-command
```


Usage
--------------------------------------------------------------------------------

```sh
$ make help
Please type: make [target]
  install         Install dotfiles to /home/tomohiro
  bundle-show     Show git submodules
  bundle-update   Update git submodules
  setup-vim       Setup vim-plug
  help            Show this help messages
```


Plugin Managers
--------------------------------------------------------------------------------

### Zsh

Update all plugins:

```
$ zplug update
```

### Vim

Update all plugins:

```
$ vi
:PlugUpdate  # Updates plugins
:PlugUpgrade # Upgrade vim-plug
```

### Tmux

Update all plugins:

```
$ (TMUX PREFFIX KEY) + U
all <ENTER>
```


Submodule Information
--------------------------------------------------------------------------------

Module Name | URL
----------- | ------------------------------------------------------------------
Xvim        | https://github.com/XVimProject/XVim
Tpdiff      | https://github.com/gongo/tpdiff
