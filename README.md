# My Personal Nvim Config
Some peeps like my setup. So here's how do it. I use a Mac. This probably won't
help too much on other systems.

## Warning
I do some a few crazy overrides of default mappings. I've done my best to
annotate those with 'Warning:' in a comment prior to the mapping.

## Setup
```sh
# Backup old config if needed.
mv ~/.config/nvim{,.bak}

# Clone this repo.
git clone git@github.com:ddrscott/config-nvm.git ~/.config/nvim

# Startup nvim. There will be errors. Just hit return.
nvim

# Install Plugins. Do this inside of NeoVim 
:PlugInstall

# Quit and Restart NeoVim
```

## Look and Feel
I use Base16 to setup colors in terminal, and Base16-vim to pass those colors
through to vim. Please follow the direction on
[base16-shell](https://github.com/chriskempson/base16-shell) go ensure things
look great in Vim.

Also please make sure your terminal is set to use xterm-256.

Here's some links to get started:

+ https://github.com/chriskempson/base16-shell
+ https://www.iterm2.com/
+ http://input.fontbureau.com/


## Setup Tags
```sh
cd /path/to/project

# In side of NeoVim tags can be generated with:
:Ctag
:CtagBundle
```
