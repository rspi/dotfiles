# Dotfiles

A repository for my personal configs..

## Installation

For OSX, install [XCode Command Line Tools] (https://developer.apple.com/downloads/index.action?=command%20line%20tools).
And then just run:

```sh
bash -c "$(curl -fsSL https://raw.github.com/rspi/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

For vimrc on windows:

```
mklink /J %USERPROFILE%\.vim %USERPROFILE%\dotfiles\link\vim
mklink /h %USERPROFILE%\.vimrc %USERPROFILE%\dotfiles\link\vimrc
```

## Thanks
<https://github.com/cowboy/dotfiles>
.. and many other dotfile repos.