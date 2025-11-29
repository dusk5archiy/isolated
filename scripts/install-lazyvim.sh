rm -rf $NVIM_CONFIG_DIR
rm -rf $LOCALAPPDATA/nvim-data
git clone https://github.com/LazyVim/starter $NVIM_CONFIG_DIR
rm -rf $LOCALAPPDATA/nvim/.git

echo 'dofile(string.format("%s\\init.lua", os.getenv("W_LAZYVIM_DIR")))' >$LOCALAPPDATA/nvim/init.lua
echo 'return dofile(string.format("%s\\lua\\config\\keymaps.lua", os.getenv("W_LAZYVIM_DIR")))' >$NVIM_CONFIG_DIR/lua/config/keymaps.lua
echo 'return dofile(string.format("%s\\lua\\config\\options.lua", os.getenv("W_LAZYVIM_DIR")))' >$NVIM_CONFIG_DIR/lua/config/options.lua
echo 'return dofile(string.format("%s\\lua\\plugins\\plugins.lua", os.getenv("W_LAZYVIM_DIR")))' >$NVIM_CONFIG_DIR/lua/plugins/plugins.lua
