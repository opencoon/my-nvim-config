local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = "/tmp/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

execute "packadd packer.nvim"

vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost minimal_init.lua PackerCompile]]
vim.cmd [[autocmd BufWritePost minimal_init.lua PackerInstall]]

-- basic ui config
vim.wo.number = true

-- lsp setup
local use = require('packer').use
require("packer").startup(
	{
		function()
			use "neovim/nvim-lspconfig"
		end,
		config = { package_root = "/tmp/site/pack" }
	}
)

-- LSP settings
-- log file location: $HOME/.local/share/nvim/lsp.log
vim.lsp.set_log_level("debug")
local nvim_lsp = require('lspconfig')

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Add the server that troubles you here
local name = "gopls"
local cmd = { "gopls", "serve" } -- needed for elixirls, omnisharp, sumneko_lua
if not name then
	print("You have not defined a server name, please edit minimal_init.lua")
end
if not nvim_lsp[name].document_config.default_config.cmd and (not cmd) then
	print([[You have not defined a server default cmd for a server
          that requires it please edit minimal_init.lua]])
end

nvim_lsp[name].setup {
	cmd = cmd,
	on_attach = on_attach,
}

print([[You can find your log at $HOME/.local/share/nvim/lsp.log. Please paste in a
  github issue under a details tag as described in the issue template.]])
