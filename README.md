### NeoVim

#### Installation

1. Install NeoVim (at least v10) & luarock
```brew install neovim luarocks```

2. Install magick
```luarocks --local --lua-version=5.1 install magick```

3. Install personal configuration
Make sure to download those in the `~/personal` directory
```
    # Harpoon2
    git clone https://github.com/ThePrimeagen/harpoon.git -b harpoon2 ~/personal/harpoon

    # Gitmoji
    git clone git@github.com:nerap/gitmoji.nvim.git ~/personal/gitmoji
```
