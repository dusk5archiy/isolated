rm -rf $LOCALAPPDATA/nvim
rm -rf $LOCALAPPDATA/nvim-data
git clone https://github.com/LazyVim/starter $LOCALAPPDATA/nvim
rm -rf $LOCALAPPDATA/nvim/.git

echo 'dofile(string.format("%s\\lazyvim\\init.lua", os.getenv("W_ISOLATED_DIR")))' > $LOCALAPPDATA/nvim/init.lua
echo 'return dofile(string.format("%s\\lazyvim\\lua\\config\\keymaps.lua", os.getenv("W_ISOLATED_DIR")))' > $LOCALAPPDATA/nvim/lua/config/keymaps.lua
echo 'return dofile(string.format("%s\\lazyvim\\lua\\config\\options.lua", os.getenv("W_ISOLATED_DIR")))' > $LOCALAPPDATA/nvim/lua/config/options.lua
echo 'return dofile(string.format("%s\\lazyvim\\lua\\plugins\\plugins.lua", os.getenv("W_ISOLATED_DIR")))' > $LOCALAPPDATA/nvim/lua/plugins/plugins.lua