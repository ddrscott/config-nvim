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
nvm

# Install Plugins. Do this inside of NeoVim 
:PlugInstall

# Quit and Restart NeoVim
```

## Look and Feel
I use Solarize, iTerm and Input Font. If solarized color themes are not
installed, yet NeoVim is going to look pretty gross. Feel free to install from
the links provided or fork and make the appropriate adjustments.

Here's some links to get started:

+ https://github.com/altercation/solarized.git
+ https://www.iterm2.com/
+ http://input.fontbureau.com/


## Setup Tags
```sh
cd /path/to/project

# In side of NeoVim tags can be generated with:
:Ctag
:CtagBundle
```
