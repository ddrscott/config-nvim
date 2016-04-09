The Neovim executable is called 'nvim'. To use your existing Vim
configuration:
    ln -s ~/.vim ~/.config/nvim
    ln -s ~/.vimrc ~/.config/nvim/init.vim
See ':help nvim' for more information on Neovim.

When upgrading Neovim, check the following page for breaking changes:
    https://github.com/neovim/neovim/wiki/Following-HEAD

If you want support for Python plugins such as YouCompleteMe, you need
to install a Python module in addition to Neovim itself.

Execute ':help nvim-python' in nvim or see the following page for more
information:
    http://neovim.io/doc/user/nvim_python.html

If you have any questions, have a look at:
    https://github.com/neovim/neovim/wiki/FAQ.
==> Summary
